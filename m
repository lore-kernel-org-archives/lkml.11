Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C0C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 23:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiCLXER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 18:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCLXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:04:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB11B642A;
        Sat, 12 Mar 2022 15:03:07 -0800 (PST)
X-UUID: 83748957e36f4c938afb4616a7e28b9a-20220313
X-UUID: 83748957e36f4c938afb4616a7e28b9a-20220313
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1790825902; Sun, 13 Mar 2022 07:03:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 13 Mar 2022 07:02:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Mar 2022 07:02:59 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <chun-jie.chen@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: Re: [PATCH v3 03/15] clk: mediatek: Add MT8186 topckgen clock support
Date:   Sun, 13 Mar 2022 07:02:59 +0800
Message-ID: <20220312230259.1028-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220311114229.32504-4-chun-jie.chen@mediatek.com>
References: <20220311114229.32504-4-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add MT8186 topckgen clock controller which provides muxes, dividers
> to handle variety clock selection in other IP blocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
