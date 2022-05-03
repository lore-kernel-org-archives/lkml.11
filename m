Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F79C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 06:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiECGeK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiECGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:34:07 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FEA381A8;
        Mon,  2 May 2022 23:30:35 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 0605826E9B2;
        Tue,  3 May 2022 08:23:01 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] iommu: M1 Pro/Max DART support
Date:   Tue,  3 May 2022 08:22:57 +0200
Message-Id: <20220503062301.20872-1-j@jannau.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

I've taken over this series to add support for DART on M1 Pro/Max from
Sven.

Since v1 we have discovered further differences in the PTE format. It
has four differences which makes it incompatible with the one in the
M1:

  - the physical addresses are shifted left by 4 bits and and have 2 more
    bits inside the PTE entries
  - the read/write protection flags are at a different position
  - the subpage protection feature is now mandatory. For Linux we can
    just configure it to always allow access to the entire page.
  - BIT(1) tags "uncached" mappings (used for the display controller)

The last difference is the most troublesome since it makes the PTE format
incomaptible with iopte_type(). Handling this inside io-pgtable-arm.c
seems manageable since DART supports just a single block size. It opens
the question at which point we decide that DART uses its own
io_pgtable_ops.

There is second type of DART (t8110) present on M1 Pro/Max SoCs which
uses the same PTE format as t6000.

Janne

Sven Peter (4):
  dt-bindings: iommu: dart: add t6000 compatible
  iommu/io-pgtable: Add DART subpage protection support
  iommu/io-pgtable: Add DART PTE support for t6000
  iommu: dart: Support t6000 variant

 .../devicetree/bindings/iommu/apple,dart.yaml |  4 +-
 drivers/iommu/apple-dart.c                    | 24 +++++-
 drivers/iommu/io-pgtable-arm.c                | 76 ++++++++++++++++++-
 drivers/iommu/io-pgtable.c                    |  1 +
 include/linux/io-pgtable.h                    |  3 +
 5 files changed, 101 insertions(+), 7 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

