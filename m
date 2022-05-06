Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1338C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 08:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390060AbiEFIXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390053AbiEFIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:23:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B766833B;
        Fri,  6 May 2022 01:19:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3899B1F406ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651825173;
        bh=jOn99sFlUaon4ViUY/sVaReudul+d+g6/yvSUHH5wZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P/LJ16sfqtpixZvqPPI9Eldivz8UZpG+OsTQhiEMvr+i3ngKPKTjqDJ0MdULTrcuf
         td8j1LluJTlesr9w1N/jDB9QAC1g6EiSWRlYcUTQZfOsGjRmC4E1H1ElsxHpTBr3aj
         voyGU/GwPspUaW9JtFIq5U+lvoNAubD+Ve4BS/0IXxEAi4CS56/X3qqNOhAaS3xCqE
         CYow+uNndAhyat7s2LZBek4DzvDyjfhgJzYFFLLghyf1PRm4Z9/1kuuNxXO6DP5a/o
         HjKWtvm4eU9MK8K3kE/SmYKhWvOBV79luD0WCVS+hSb56kwnZ4YTpXM4MyxZD7X1MJ
         ILBZuuKYzQ2OA==
Message-ID: <eb3884ac-56b2-4c37-05bc-82e8e44b22d2@collabora.com>
Date:   Fri, 6 May 2022 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] soc: mediatek: devapc: Add support for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     runyang.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
 <20220504115501.3490-4-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504115501.3490-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/05/22 13:55, Rex-BC Chen ha scritto:
> Add devapc data and compatible to support MT8186 devapc.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

