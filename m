Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9785C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351590AbiCXQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiCXQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:14:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA5A66DC;
        Thu, 24 Mar 2022 09:12:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 912651F457D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648138354;
        bh=WCk4dzdn3DtFOiWPLHNJq946UphbiJkQG7+kTAtMZdM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H2r7TNfTDpxaKSzjPVT4jB1Mv1PmRu810K99bdcoKktnGfjSaQNsCuuOOiOrROAv2
         WAZjuaXdyr6MVvqBpeXb/Ppm5sc66G6BdQIgo65vRbdfRxZB5j3/tkddMZi80SRGGf
         rSV+rwV3ON6wXU68DHcxIf0Mq/9JRaakWy9QRs2K97VEcX0abxRre8f5bGWrdMfZ96
         rCu+B3ki5EreP4yUybGMhb7+JhNQlM3+UOzXFGhjRSLtbAXe2SCKfwf7c/qzTD9sAn
         g3Bq+0E63Ezc0ptia0pnrXKKCceZk041QssxkgEIZw2Ow00o/vAqrwzfIOXCFAmfOr
         IXBAtp09bIaZw==
Message-ID: <d49177c6-651d-e445-4421-1078ba11efb8@collabora.com>
Date:   Thu, 24 Mar 2022 17:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com, tzungbi@google.com,
        miles.chen@mediatek.com, yc.hung@mediatek.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-6-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/03/22 06:38, Trevor Wu ha scritto:
> This patch adds support for mt8195 board with mt6359, max98390 and
> rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


