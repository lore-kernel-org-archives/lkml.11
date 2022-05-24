Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiEXKiP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiEXKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:38:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F93252B6;
        Tue, 24 May 2022 03:38:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D37631F42A6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653388682;
        bh=kAIOsWqAMnO77xueu3Jw6gGhUwicsViTsQBfZcFuvfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EhUmzDLt6WDvpAqb5EoHZudGltwo6RmNjLHv4rh3UaVC471tvIHAk82ala1QPJl99
         xiSAKZuUauXTZpDGcHpXBB+zHXy/J44Q6vVUfMmo4OSxHqEFDCzC044JpOYku6f1sD
         +lLQgGimgCA3B5OPv9ry5dhNGjvwVxjEZxn7v4ufcMBTH2A87yqjblnZrKzLK1LMIQ
         XRk3/+O+IiauYLSBowNKvl4mQCCpT6aJFHmrfMaL34CLciLXQgphyp5RLTOANxtHXl
         uBLpXyoHIF75EPNqToXQjColYdiaNmBya3lbmq6w+oLokegoTlKfXRYpnk+9clenan
         96rqLBFKEBwog==
Message-ID: <d97f0fd1-bbaf-331c-6b51-fc72648fab43@collabora.com>
Date:   Tue, 24 May 2022 12:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] dt-bindings: usb: mtk-xhci: add support 'resets'
 property
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 11:04, Chunfeng Yun ha scritto:
> Add 'resets' property to support IP reset usually by top pericfg.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



