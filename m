Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F03C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 01:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbiFDBdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiFDBdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC015FEA;
        Fri,  3 Jun 2022 18:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E1261618;
        Sat,  4 Jun 2022 01:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF421C385A9;
        Sat,  4 Jun 2022 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654306401;
        bh=GAofHUOFsy2k8fM1PqdU/rnt0EVa7n/zzBRIVpbGlCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfyUyfNwGhC6rg8WLSXtVnibaWr8VJ7y7tWb08qRi9so4UVINLWAKuf8pow46q+xE
         DwyZRL7eUphwLsdSY1IEe6+CqL588+le7R+CqD2p0mTjlhMbsQ0kJya2ElthDINoyp
         Ho3Hto1FuW7Lm/oH8XOxdYW3yfqwyLLBAl1wQOGjq2Zkh6qVCDlqsH3b1GGc1TGe2D
         rqyKjOmz1PWXcU2Xt/Ana0Lqpvn5uJaRgUVbSoVT1SIlLZxHYmepcNZJ5KU0s9qRmN
         m5QNmSWmjjOru7RNXGqu3lUf8RBAb0WHLXy9nntP0Aus6l3j9Pt+QrUkv9SMuXvJP6
         rgGCdBYsaxMwA==
Date:   Fri, 3 Jun 2022 18:33:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hifoolno <553441439@qq.com>
Subject: Re: [PATCH 1/1] nfc: nfcmrvl: Fix memory leak in
 nfcmrvl_play_deferred
Message-ID: <20220603183313.50aa47e1@kernel.org>
In-Reply-To: <20220603163127.4994-1-ruc_zhangxiaohui@163.com>
References: <20220603163127.4994-1-ruc_zhangxiaohui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jun 2022 00:31:27 +0800 Xiaohui Zhang wrote:
> From: hifoolno <553441439@qq.com>
> 
> Currently usb_submit_urb is called directly to submit deferred tx
> urbs after unanchor them.
> 
> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
> and cause memory leak.
> 
> Put those urbs in tx_anchor to avoid the leak, and also fix the error
> handling.
> 
> Signed-off-by: hifoolno <553441439@qq.com>

hifoolno is too close to "Hi Fool" for comfort. Is that really your
name?

Also the patch doesn't build.
