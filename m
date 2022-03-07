Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD14C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiCGPwT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCGPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:52:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C192D33;
        Mon,  7 Mar 2022 07:51:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B0E2B30B;
        Mon,  7 Mar 2022 16:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646668278;
        bh=SfxEEhRPvuDd44PxQZDXnX/DJ2LqiwGXoarMuJp/ZM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8ImryOJpGHpy5ygU0+dU6R2BhB3NGcuHbiW2AFKjATgPv9k2CQe2tGPptepqjkK5
         diWkulTMnS2WWAi4ycvJW5/QCFZNvk9B93dackkT/b7YjSFI2YgRAGlOgQmR9dwvkU
         fXI6DpLrdmaARIp54QP+2+HuL7TIsF240W0BxaZg=
Date:   Mon, 7 Mar 2022 17:51:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v1 0/2] Revert vendor property from anx7625 bindings
Message-ID: <YiYp6bKJPdIoKD+f@pendragon.ideasonboard.com>
References: <20220307154558.2505734-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307154558.2505734-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Mar 07, 2022 at 04:45:56PM +0100, Robert Foss wrote:
> An issue[1] related to how the V4L2_FWNODE_BUS_TYPE_PARALLEL flag is mis-used
> was found in recent addition to the anx7625 driver.
> 
> In order to not introduce this issue into the ABI, let's revert the changes
> to the anx7625 dt-binding related to this.
> 
> [1] https://lore.kernel.org/all/YiTruiCIkyxs3jTC@pendragon.ideasonboard.com/
> 
> Robert Foss (2):
>   Revert "dt-bindings:drm/bridge:anx7625:add vendor define"
>   Revert "arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI
>     endpoint"

If this is enough to avoid the wrong bus-type becoming an ABI, even if
the corresponding driver support isn't reverted, then, for the whole
series,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  .../display/bridge/analogix,anx7625.yaml      | 65 +------------------
>  .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  2 -
>  2 files changed, 2 insertions(+), 65 deletions(-)

-- 
Regards,

Laurent Pinchart
