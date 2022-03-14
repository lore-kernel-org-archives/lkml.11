Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiCNK0c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCNK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:26:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C53ED33;
        Mon, 14 Mar 2022 03:25:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B83AA1F434FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253519;
        bh=CMDLyrkwOqWTgGkVJSKbrJxuQwnDyjhV3L0QailiIj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kB3fV4sKc0tD7r3/SJxX8Rl5Debi9JeEKE/AlO+V1kyORZVET0wnKCqS5m/qCbD36
         VGOkrAxa1UGiyaw06eshc8SRqa2lujdY8Fk9fvVOKwnJECoJIc0XjpP0eKFUXUayqb
         hlGjh/UQVKcCKW95Jc/BfmgpNTOHVDQ9o2BRjGfkCzc3pyZSIKR1wz9LLbhNS2j8Oa
         0SBgCQWR05ZRqiwJOGGvkKHxpsR9SCYsVnQd0/JKVszQsW41sDMw1WHcDdZ9RZqVPm
         N/fgKs5kSa4RprKUgKD+GeqN9UGjB+Jj5XznV/gr+o0MmhrQE51U/z/aEi5EDrj9hk
         dk/avJx8Y5jJg==
Message-ID: <fe924e75-6543-2b5a-b354-6eb38fb1cbe6@collabora.com>
Date:   Mon, 14 Mar 2022 11:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 04/19] ASoC: mediatek: mt8186: support adda in platform
 driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-5-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-5-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 adda dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 878 ++++++++++++++++++++
>   1 file changed, 878 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> 
