{-# OPTIONS_GHC -O0 #-}
{-# LANGUAGE DeriveAnyClass       #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE UndecidableInstances #-}
module BarbiesW
  ( Record1W(..)
  , Record3W(..)

  , Record1WS(..)
  , Record3WS(..)

  , Sum3W(..)

  , CompositeRecordW(..)
  , SumRecW(..)
  , InfRecW(..)

  , NestedFW(..)
  )

where

import Data.Barbie
import Data.Barbie.Bare

import Data.Typeable
import GHC.Generics
import Test.Tasty.QuickCheck

----------------------------------------------------
-- Product Barbies
----------------------------------------------------

data Record1W t f
  = Record1W { rec1w_f1 :: Wear t f Int }
  deriving (Generic, Typeable)


instance FunctorB (Record1W Bare)
instance FunctorB (Record1W Covered)
instance TraversableB (Record1W Covered)
instance ProductB (Record1W Covered)
instance ConstraintsB (Record1W Bare)
instance ConstraintsB (Record1W Covered)
instance ProofB (Record1W Covered)
instance BareB Record1W


deriving instance AllB Show (Record1W Bare) => Show (Record1W Bare f)
deriving instance AllB Eq   (Record1W Bare) => Eq   (Record1W Bare f)
deriving instance AllB (ClassF Show f) (Record1W Covered) => Show (Record1W Covered f)
deriving instance AllB (ClassF Eq   f) (Record1W Covered) => Eq   (Record1W Covered f)

instance AllB (ClassF Arbitrary f) (Record1W Covered) => Arbitrary (Record1W Covered f) where
  arbitrary = Record1W <$> arbitrary


data Record1WS t f
  = Record1WS { rec1ws_f1 :: !(Wear t f Int) }
  deriving (Generic, Typeable)


instance FunctorB (Record1WS Bare)
instance FunctorB (Record1WS Covered)
instance TraversableB (Record1WS Covered)
instance ProductB (Record1WS Covered)
instance ConstraintsB (Record1WS Bare)
instance ConstraintsB (Record1WS Covered)
instance ProofB (Record1WS Covered)
instance BareB Record1WS


deriving instance AllB Show (Record1WS Bare) => Show (Record1WS Bare f)
deriving instance AllB Eq   (Record1WS Bare) => Eq   (Record1WS Bare f)
deriving instance AllB (ClassF Show f) (Record1WS Covered) => Show (Record1WS Covered f)
deriving instance AllB (ClassF Eq   f) (Record1WS Covered) => Eq   (Record1WS Covered f)

instance AllB (ClassF Arbitrary f) (Record1WS Covered) => Arbitrary (Record1WS Covered f) where
  arbitrary = Record1WS <$> arbitrary

data Record3W t f
  = Record3W
      { rec3w_f1 :: Wear t f Int
      , rec3w_f2 :: Wear t f Bool
      , rec3w_f3 :: Wear t f Char
      }
  deriving (Generic, Typeable)


instance FunctorB (Record3W Bare)
instance FunctorB (Record3W Covered)
instance TraversableB (Record3W Covered)
instance ProductB (Record3W Covered)
instance ConstraintsB (Record3W Bare)
instance ConstraintsB (Record3W Covered)
instance ProofB (Record3W Covered)

instance BareB Record3W

deriving instance AllB Show (Record3W Bare) => Show (Record3W Bare f)
deriving instance AllB Eq   (Record3W Bare) => Eq   (Record3W Bare f)
deriving instance AllB (ClassF Show f) (Record3W Covered) => Show (Record3W Covered f)
deriving instance AllB (ClassF Eq   f) (Record3W Covered) => Eq   (Record3W Covered f)

instance AllB (ClassF Arbitrary f) (Record3W Covered) => Arbitrary (Record3W Covered f) where
  arbitrary = Record3W <$> arbitrary <*> arbitrary <*> arbitrary


data Record3WS t f
  = Record3WS
      { rec3ws_f1 :: !(Wear t f Int)
      , rec3ws_f2 :: !(Wear t f Bool)
      , rec3ws_f3 :: !(Wear t f Char)
      }
  deriving (Generic, Typeable)


instance FunctorB (Record3WS Bare)
instance FunctorB (Record3WS Covered)
instance TraversableB (Record3WS Covered)
instance ProductB (Record3WS Covered)
instance ConstraintsB (Record3WS Bare)
instance ConstraintsB (Record3WS Covered)
instance ProofB (Record3WS Covered)
instance BareB Record3WS

deriving instance AllB Show (Record3WS Bare) => Show (Record3WS Bare f)
deriving instance AllB Eq   (Record3WS Bare) => Eq   (Record3WS Bare f)
deriving instance ConstraintsOf Show f (Record3WS Covered) => Show (Record3WS Covered f)
deriving instance ConstraintsOf Eq   f (Record3WS Covered) => Eq   (Record3WS Covered f)

instance AllB (ClassF Arbitrary f) (Record3WS Covered) => Arbitrary (Record3WS Covered f) where
  arbitrary = Record3WS <$> arbitrary <*> arbitrary <*> arbitrary


----------------------------------------------------
-- Sum Barbies
----------------------------------------------------

data Sum3W t f
  = Sum3W_0
  | Sum3W_1 (Wear t f Int)
  | Sum3W_2 (Wear t f Int) (Wear t f Bool)
  deriving (Generic, Typeable)

instance FunctorB (Sum3W Bare)
instance FunctorB (Sum3W Covered)
instance TraversableB (Sum3W Covered)
instance ConstraintsB (Sum3W Bare)
instance ConstraintsB (Sum3W Covered)
instance BareB Sum3W

deriving instance AllB Show (Sum3W Bare) => Show (Sum3W Bare f)
deriving instance AllB Eq   (Sum3W Bare) => Eq   (Sum3W Bare f)
deriving instance AllB (ClassF Show f) (Sum3W Covered) => Show (Sum3W Covered f)
deriving instance AllB (ClassF Eq   f) (Sum3W Covered) => Eq   (Sum3W Covered f)

instance AllB (ClassF Arbitrary f) (Sum3W Covered) => Arbitrary (Sum3W Covered f) where
  arbitrary
    = oneof
        [ pure Sum3W_0
        , Sum3W_1 <$> arbitrary
        , Sum3W_2 <$> arbitrary <*> arbitrary
        ]


-----------------------------------------------------
-- Composite and recursive
-----------------------------------------------------


data CompositeRecordW t f
  = CompositeRecordW
      { crecw_f1 :: Wear t f Int
      , crecw_F2 :: Wear t f Bool
      , crecw_f3 :: Record3W t f
      , crecw_f4 :: Record1W t f
      }
  deriving (Generic, Typeable)

instance FunctorB (CompositeRecordW Bare)
instance FunctorB (CompositeRecordW Covered)
instance TraversableB (CompositeRecordW Covered)
instance ProductB (CompositeRecordW Covered)
instance ConstraintsB (CompositeRecordW Bare)
instance ConstraintsB (CompositeRecordW Covered)
instance ProofB (CompositeRecordW Covered)
instance BareB CompositeRecordW

deriving instance AllB Show (CompositeRecordW Bare) => Show (CompositeRecordW Bare f)
deriving instance AllB Eq   (CompositeRecordW Bare) => Eq   (CompositeRecordW Bare f)
deriving instance AllB (ClassF Show f) (CompositeRecordW Covered) => Show (CompositeRecordW Covered f)
deriving instance AllB (ClassF Eq   f) (CompositeRecordW Covered) => Eq   (CompositeRecordW Covered f)

instance AllB (ClassF Arbitrary f) (CompositeRecordW Covered) => Arbitrary (CompositeRecordW Covered f) where
  arbitrary
    = CompositeRecordW <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary


data SumRecW t f
  = SumRecW_0
  | SumRecW_1 (Wear t f Int)
  | SumRecW_2 (Wear t f Int) (SumRecW t f)
  deriving (Generic, Typeable)

instance FunctorB (SumRecW Bare)
instance FunctorB (SumRecW Covered)
instance TraversableB (SumRecW Covered)
instance ConstraintsB (SumRecW Bare)
instance ConstraintsB (SumRecW Covered)
instance BareB SumRecW

deriving instance AllB Show (SumRecW Bare) => Show (SumRecW Bare f)
deriving instance AllB Eq   (SumRecW Bare) => Eq   (SumRecW Bare f)
deriving instance AllB (ClassF Show f) (SumRecW Covered) => Show (SumRecW Covered f)
deriving instance AllB (ClassF Eq   f) (SumRecW Covered) => Eq   (SumRecW Covered f)

instance AllB (ClassF Arbitrary f) (SumRecW Covered) => Arbitrary (SumRecW Covered f) where
  arbitrary
    = oneof
        [ pure SumRecW_0
        , SumRecW_1 <$> arbitrary
        , SumRecW_2 <$> arbitrary <*> arbitrary
        ]

data InfRecW t f
  = InfRecW { irw_1 :: Wear t f Int, irw_2 :: InfRecW t f }
  deriving (Generic, Typeable)


instance FunctorB (InfRecW Bare)
instance FunctorB (InfRecW Covered)
instance TraversableB (InfRecW Covered)
instance ProductB (InfRecW Covered)
instance ConstraintsB (InfRecW Bare)
instance ConstraintsB (InfRecW Covered)
instance ProofB (InfRecW Covered)
instance BareB InfRecW

deriving instance AllB Show (InfRecW Bare) => Show (InfRecW Bare f)
deriving instance AllB Eq   (InfRecW Bare) => Eq   (InfRecW Bare f)
deriving instance AllB (ClassF Show f) (InfRecW Covered) => Show (InfRecW Covered f)
deriving instance AllB (ClassF Eq   f) (InfRecW Covered) => Eq   (InfRecW Covered f)

-----------------------------------------------------
-- Nested under functors
-----------------------------------------------------

data NestedFW t f
  = NestedFW
      { npfw_1 :: Wear t f Int
      , npfw_2 :: [Record3W t f]
      , npfw_3 :: Maybe (Sum3W t f)
      , npfw_4 :: Maybe (NestedFW t f)
      }
  deriving (Generic, Typeable)



instance FunctorB (NestedFW Bare)
instance FunctorB (NestedFW Covered)
instance TraversableB (NestedFW Covered)
instance BareB NestedFW
-- instance ConstraintsB (NestedFW Bare)
-- instance ConstraintsB (NestedFW Covered)

deriving instance Show (NestedFW Bare f)
deriving instance Eq   (NestedFW Bare f)
deriving instance (Show (f Int), Show (Record3W Covered f), Show (Sum3W Covered f)) => Show (NestedFW Covered f)
deriving instance (Eq   (f Int), Eq   (Record3W Covered f), Eq   (Sum3W Covered f)) => Eq   (NestedFW Covered f)

instance (Arbitrary (f Int), Arbitrary (f Bool), Arbitrary (f Char)) => Arbitrary (NestedFW Covered f) where
  arbitrary = NestedFW <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary