Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18529C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiDFNiZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiDFNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:37:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B368FBA1;
        Wed,  6 Apr 2022 03:39:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 62E321F40636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649241544;
        bh=Wt6H1/5KeIwiv84NwDktEXWbagGeTc+A2tTQdBJ3m/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hJXdG7l7xrjiCg6g8MWK7luueDWq70aow8lvQ6vnOWPs9zVmi0JNIIc5MWqIyomGP
         wkMZgWzgAdiwsoVsfGspG3eIJsMdhGaVqiX/foIUhBT6QcVRpYeJCi4l6LH9+AfNoA
         B4erpzjUZ5+wNT/w4SX6p0QB7uae9VJ+LNVqo8Jp1sFBDdu76zuAbqMsMhS9t+Oakt
         SI7wF/TKilhHc0+wt379jA/DQ59AcOOkDETmpZIAzVg8U2h6Isuhnk5CQA3zyXxpO0
         FILEIiEBjOnrt/MGSL8aWwAyOuHgrh+1uI8ON3fe7f5zvk9M1CawuUF+JtdoKi1ikq
         V3LYUnWeMTVFw==
Message-ID: <ff4e0e14-b0cc-feed-6038-45d383a0fd4a@collabora.com>
Date:   Wed, 6 Apr 2022 12:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] arm64: dts: mt8183: Correct disp_aal node compatible
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, airlied@linux.ie,
        yongqiang.niu@mediatek.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, allen-kh.cheng@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
 <20220406094654.29722-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220406094654.29722-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/04/22 11:46, Rex-BC Chen ha scritto:
> The driver data of MT8183 and MT8173 are different.
> The value of has_gamma for MT8173 is true while the value of MT8183 is
> false. Therefore, the compatible of disp_aal for MT8183 is not suitable
> for the compatible for MT8173.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
