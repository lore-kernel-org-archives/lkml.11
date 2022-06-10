Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CAAC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiFJKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245341AbiFJKks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:40:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A001EA045;
        Fri, 10 Jun 2022 03:36:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C57C660173C;
        Fri, 10 Jun 2022 11:36:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654857373;
        bh=Sl4XTI9fTeLYEGMYtkmUrZfpXPFc4NtB7yxUPzBz5P0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l3ooxUPnGPn7Wg1eAjlIfW0TigLrxkwaU37Ktz7fJpNpqghDtPC5QhreI3Y7iqTQ2
         MQPMroHxVHkXOjRidl5LfRlIQzKyEM0XDKJON1ntm5FwoBIilEzans4bR3Exy8MQ+y
         +2tpmDDVI7y+gBECo6irvnSAsmYvzMAlmiuJIlYQi+p6bAX6YBLmKDg1PDEM/M63Fu
         ETynncpDInuWfW/lQqrW1AmR/Kqt4XLKUx0T4+OMk3zGEnSqaSZ/ZdeHJIQo2L4KJh
         mMiyg5wqy3ZCrL4xZo3TpTPHxGgJnBmCWu8F28UOnlhH6tvyPzkH+zfnclsLfiohbh
         ORITjCwV0iR7A==
Message-ID: <63e171dc-e1f6-3487-66c4-a5cf36d2471b@collabora.com>
Date:   Fri, 10 Jun 2022 12:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] usb: mtu3: sync interrupt before unbind the udc
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220609074233.15532-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609074233.15532-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/22 09:42, Chunfeng Yun ha scritto:
> Register gadget irq to avoid the interrupt handler is occurred
> or scheduled during the unbind flow, may happen when do android
> function switch stress test.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

