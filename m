Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jan 2022 12:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354743AbiASMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jan 2022 07:37:11 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:53278 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354472AbiASMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:36:42 -0500
X-UUID: 604383952e9a41c7bf15010cb139e55a-20220119
X-UUID: 604383952e9a41c7bf15010cb139e55a-20220119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 774181033; Wed, 19 Jan 2022 20:36:39 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 20:36:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Jan
 2022 20:36:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:36:37 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH 0/1] Add clock support for mt7986
Date:   Wed, 19 Jan 2022 20:36:23 +0800
Message-ID: <20220119123624.10043-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller nodes, include 40M clock source, topckgen,
infracfg, apmixedsys and ethernet subsystem.

Sam Shih (1):
  arm64: dts: mediatek: add clock support for mt7986a

 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 68 +++++++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

-- 
2.29.2

