Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD487C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiEYUx5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 16:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEYUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:53:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848390CC8;
        Wed, 25 May 2022 13:53:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 841561F4268A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653512032;
        bh=JayclhC6KF2KjXxwe9UBTJau5WIH16YxRj272sxRyX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECuo2A5BML0Z5RO9YZdLhFbyvNvnUVwNVOyHg+CvMtoF/sCu8w2tvmgQSxaMXYNq6
         ZGz/CqMZ7nR48ovPBo2M6Tios2gZJ+M1ey3WbNkCLGyhidE7jpFTNMKY5MuY+eFXRD
         mjyK9h4+UAm0Mmo5ki9DLv8EjE48UjMr6y8Nx2Sn7dKGt/BFFny9xpciqkcIZQFOLd
         /uqm/Y/LSF9Zt0ju9E6yTlgWBdZYPA+Q8X8CdD2wSHdR0C6TLD3L7eXrAhNMt+tdie
         JFL0AEJYHcpu75Fadb+8WGX7WaY3YRCHrF7HFJ86OPYdlG1hKhF6ZNwHIvkVq/yWk3
         fMz/Lp2SS8m6Q==
Date:   Wed, 25 May 2022 16:53:46 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <20220525205346.6ik67nduv3zexl4p@notapiano>
References: <20220509205847.607076-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509205847.607076-1-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:58:47PM -0400, Nícolas F. R. A. Prado wrote:
> The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
> share the same clock and act as a single interface with both input and
> output. Add patterns for these properties in the dt-binding. The
> property is split into two patterns in order to allow all valid
> interface pairings.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> The series from v1 of this patch was merged although some changes were
> still needed in this patch, so the v1 of this patch was reverted [1] and
> this standalone commit addresses the feedback from v1 and readds the
> property.
> 
> [1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com
> 
> v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/
> 
> Changes in v2:
> - Added "mediatek," prefix to property
> - Rewrote and added more information to property description
> - Split into two patterns to validate that output-input pairings are
>   done
> 
>  .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Gentle ping on this one. Any feedback for v2?

Thanks,
Nícolas
