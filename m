Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jan 2022 12:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354771AbiASMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jan 2022 07:37:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:53874 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354758AbiASMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:37:13 -0500
X-UUID: 7b68ce19d6114aa09c1dca6feb79c7c1-20220119
X-UUID: 7b68ce19d6114aa09c1dca6feb79c7c1-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 143840468; Wed, 19 Jan 2022 20:37:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Jan 2022 20:37:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:37:08 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 0/1] Relicense mt7986 clock driver to GPL-2.0
Date:   Wed, 19 Jan 2022 20:36:57 +0800
Message-ID: <20220119123658.10095-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous mt7986 clock drivers were incorrectly marked as GPL-1.0.
This patch changes the driver to the standard GPL-2.0 license.

Sam Shih (1):
  clk: mediatek: relicense mt7986 clock driver to GPL-2.0

 drivers/clk/mediatek/clk-mt7986-apmixed.c  | 2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.29.2

