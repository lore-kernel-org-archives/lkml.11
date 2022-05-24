Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63152C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 10:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiEXKiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiEXKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:38:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD0252B6;
        Tue, 24 May 2022 03:38:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 23BCF1F4297D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653388678;
        bh=etll5o+x30UMEkWrtEntHbi6Qfc9TIi2cHHAAYdcrI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RB+miw2uhWHevfkESfd+oNlk+0IsU+bKudXzWexwtjfck4oXzg7WA1oK2Y+/PeP1V
         e+Sp3oyLW/rc2RYTdwI4mI8stvYyq+pbN4ENWq0alq11rhrbd9wFTy6TcLkDTou/mb
         ag4SjRvVlUDOj5a5jMGNLYG4zujWKMkSkF0wWCFCFVyMuEU2gPUCpPCbBdHD/eTktK
         YXkIlaGWUalnpy2zv1L9VjBPAp1dWLrYlXmW87Y75MpuclXmFBuHYTHxYiY3rsduEC
         gDAjvENl0hICufAjPuuaYxmrX/spznt2sbygmn7F0Ur3yq9iHYj8XNgxSHf5iIriKr
         vx3j0eZboO6Gg==
Message-ID: <9cb97ed4-2951-360a-2a0c-773a8d78116c@collabora.com>
Date:   Tue, 24 May 2022 12:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] usb: mtu3: add support controller reset
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>
References: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
 <20220523090449.14430-4-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523090449.14430-4-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 11:04, Chunfeng Yun ha scritto:
> Add support controller reset via a reset-controller usually in infracfg,
> it's different with the software reset by IPPC which only used to reset MAC,
> and it will also reset IPPC meanwhile.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

