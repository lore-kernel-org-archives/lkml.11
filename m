Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B1C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 07:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiBLHsB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 02:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiBLHr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:47:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7926AEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 23:47:55 -0800 (PST)
X-UUID: 32076c34da7549a7a2be3e1cbf29f30d-20220212
X-UUID: 32076c34da7549a7a2be3e1cbf29f30d-20220212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 319208344; Sat, 12 Feb 2022 15:47:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 12 Feb 2022 15:47:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Feb 2022 15:47:50 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <andreyknvl@gmail.com>,
        <anshuman.khandual@arm.com>, <ardb@kernel.org>, <arnd@arndb.de>,
        <dvyukov@google.com>, <geert+renesas@glider.be>,
        <glider@google.com>, <kasan-dev@googlegroups.com>,
        <linus.walleij@linaro.org>, <linux@armlinux.org.uk>,
        <lukas.bulwahn@gmail.com>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ryabinin.a.a@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v2 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sat, 12 Feb 2022 15:47:45 +0800
Message-ID: <20220212074747.10849-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the framework of KASAN_VMALLOC is well-developed,
It's easy to support for ARM that simply not to map shadow of VMALLOC
area on kasan_init.

This can fix ARM_MODULE_PLTS with KASAN and provide first step
to support CONFIG_VMAP_STACK in ARM.
    

Patch base on v5.16

Test on
1. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping.
2. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping + LPAE.
3. Qemu with memory 2G and vmalloc=500M for 2G/2G mapping.


v2:
    rebase on 5.17-rc3


Lecopzer Chen (2):
  arm: kasan: support CONFIG_KASAN_VMALLOC
  arm: kconfig: fix MODULE_PLTS for KASAN with KASAN_VMALLOC

 arch/arm/Kconfig         | 2 ++
 arch/arm/mm/kasan_init.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1

