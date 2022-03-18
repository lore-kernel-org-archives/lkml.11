Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiCRRfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCRRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:35:34 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D845188A19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:34:14 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id VGUFnWu9IvjW4VGUFnSqLL; Fri, 18 Mar 2022 18:34:13 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 18 Mar 2022 18:34:13 +0100
X-ME-IP: 90.126.236.122
Message-ID: <3494995c-b173-cc99-ef9d-f5dafb543353@wanadoo.fr>
Date:   Fri, 18 Mar 2022 18:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5.10 20/23] bnx2: Fix an error message
Content-Language: fr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20220317124525.955110315@linuxfoundation.org>
 <20220317124526.543596817@linuxfoundation.org>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220317124526.543596817@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one should be removed, the message is correct in 5.10.

CJ

Le 17/03/2022 à 13:46, Greg Kroah-Hartman a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> [ Upstream commit 8ccffe9ac3239e549beaa0a9d5e1a1eac94e866c ]
>
> Fix an error message and report the correct failing function.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/net/ethernet/broadcom/bnx2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
> index 633b10389653..93129d9a87f4 100644
> --- a/drivers/net/ethernet/broadcom/bnx2.c
> +++ b/drivers/net/ethernet/broadcom/bnx2.c
> @@ -8229,7 +8229,7 @@ bnx2_init_board(struct pci_dev *pdev, struct net_device *dev)
>   		rc = pci_set_consistent_dma_mask(pdev, persist_dma_mask);
>   		if (rc) {
>   			dev_err(&pdev->dev,
> -				"pci_set_consistent_dma_mask failed, aborting\n");
> +				"dma_set_coherent_mask failed, aborting\n");
>   			goto err_out_unmap;
>   		}
>   	} else if ((rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) != 0) {
