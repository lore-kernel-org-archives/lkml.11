Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF6AC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 10:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349244AbiBNKsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:48:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbiBNKru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:47:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830DCBA778;
        Mon, 14 Feb 2022 02:10:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BD1B71F43426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644833412;
        bh=29qsQZwz4Yb/3pSTyMTim4dCk+vsaoydiBzpY/Zd12o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GsN2z3kF82gaI49FTrcAgoe+WQYzf2HMM47AgfbuPOK77RYECLv7r17iplEBXUzce
         GoZvRB+HpeSKS42RZicmAjhDgXSGNxmp/QO5WqMmv8ViTuuUJ6G4IuPXBIveelgdxn
         qcczwC9PZGEu6ZciyMVafKJnJ1PmV6RwXhSObW/MxiH0GKUTFi60O1FcRXi7JALcfp
         52sILPgY5otX0GgFPofs6++L6+lG5d/dgg89VUmdFrIi2gWD/Zc5bDl32K20gnP4p9
         rUWomhIhl+BBJA/MOx5Qzmbzmo2JxrRminfpsesIimzi26qW12rbSLGTWU/HTdULIw
         xZs8haxjkEBFQ==
Message-ID: <7efb2a87-1b8e-5bab-651f-ffa21ea8d716@collabora.com>
Date:   Mon, 14 Feb 2022 11:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/2] drm/panel: Add inx Himax8279d MIPI-DSI LCD panel
 driver
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        devicetree@vger.kernel.org
References: <20220213063151.3321331-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220213063151.3321331-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/22 07:31, Hsin-Yi Wang ha scritto:
> From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> 
> Add STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

I have no way of testing this driver but the code itself looks good to me,
so, strictly for the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v2->v3:
> rebase to next-20220211
> ---
>   drivers/gpu/drm/panel/Kconfig                 |   9 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   .../gpu/drm/panel/panel-innolux-himax8279d.c  | 515 ++++++++++++++++++
>   3 files changed, 525 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-innolux-himax8279d.c
> 
