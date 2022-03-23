Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8810EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiCWMTD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiCWMTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:19:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3E762AC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:17:27 -0700 (PDT)
X-UUID: 1a7ef482162a47e0a248f8643f1667c3-20220323
X-UUID: 1a7ef482162a47e0a248f8643f1667c3-20220323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 161689378; Wed, 23 Mar 2022 20:17:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 20:17:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 20:17:22 +0800
Message-ID: <be945651bcb531a14d6f264be346642d4438238b.camel@mediatek.com>
Subject: Re: [PATCH v3, 0/3] Add mt8186 dsi compatoble & Convert 
 dsi_dtbinding to .yaml
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, <allen-kh.cheng@mediatek.com>
Date:   Wed, 23 Mar 2022 20:17:21 +0800
In-Reply-To: <1647408934-15775-1-git-send-email-xinlei.lee@mediatek.com>
References: <1647408934-15775-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-16 at 13:35 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Changes since v2:
> 1. Added #address-cells, #size-cells two properties.
> 2. Fix some formatting issues.
> 
> Changes since v1:
> 1. Delete the mediatek,dsi.txt & Add the mediatek,dsi.yaml.
> 2. Ignore the Move the getting bridge node function patch for V1.
> 
> Xinlei Lee (3):
>   dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
>   dt-bindings: display: mediatek: dsi: Add compatible for MediaTek
>     MT8186
>   drm/mediatek: Add mt8186 dsi compatible to mtk_dsi.c
> 
>  .../display/mediatek/mediatek,dsi.txt         | 62 ------------
>  .../display/mediatek/mediatek,dsi.yaml        | 97
> +++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dsi.c            |  8 ++
>  3 files changed, 105 insertions(+), 62 deletions(-)
>  delete mode 100644
> Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
>  create mode 100644
> Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml

Hello Xinlei,

I think you should cc devicetree@vger.kernel.org if you have binding
patches.
Please send next version with it.

Thanks.

BRs,
Rex

