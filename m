Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiDFNio (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiDFNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:37:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD368F4CC;
        Wed,  6 Apr 2022 03:38:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C74DE1F40636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649241526;
        bh=5GWmZjBirWLKxTJDH+AOnbEW/7YRX30utZckHcSznsA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b1yhGPYeG8w7Hp3otl5OwFcOZbuTdGDLENoQCChDRid7NyaHwJgMzTFezCf/36fV2
         fuQOYSawPvsvy2Gil0LJd3sKx2+iNHU5Z4uP1KTdPjDCbN6zti6mJwrFqE/0mULBDa
         MtpEJV+jra0//NFIIRW8QWD0FXJMBPQqRUx5zS7pyhDoIGAMd3uI9rU/mc7OwIX76V
         4CbeW4SEYM6BK09Mdij+l+jwkckSSGuGVOX6qG0lKjWZSGR43dbXQSq+O7AfSps4PQ
         D+HY0d/19iLzO9ZI2pjsLvnk0S8sbVY7t0/n1m8IXHILCglQspsK4DfeKx3NeaVWux
         V7Uhzleh+dAMA==
Message-ID: <19a1af29-19a7-a546-b565-a2cc973a7f28@collabora.com>
Date:   Wed, 6 Apr 2022 12:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: Correct disp_aal
 binding for MT8183
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
 <20220406094654.29722-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220406094654.29722-2-rex-bc.chen@mediatek.com>
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

Hello!
Yes, I definitely agree with this change, it makes no sense to have both
8173 and 8183 compatibles for 8183 (and similar).

Though, please, add a note in this commit message advertising that the
mistake was only in the yaml binding, as the driver doesn't require any
functional changes, so that things are clear for people with less expertise
on MediaTek platforms.

After that:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
