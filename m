Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 02:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiFHCzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444406AbiFHCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7AC1BBAC5;
        Tue,  7 Jun 2022 17:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F157617A1;
        Wed,  8 Jun 2022 00:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9750BC34114;
        Wed,  8 Jun 2022 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654647956;
        bh=Swm8frSQYF0dasnZJ7rfGFppedE+tAaQ3A6Qn1RLL4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rzzogDpbsRIe8kdUfMX4KxxsBmYM5b21oee7lee8hmr0Hu2pzI8Xk8IDGxFFIfx7l
         wF0TmrAZA+kfgY7aYxSXJLGt6NeWzXlBPbldOXGTi+AVdtUvQIfpYX0VDsfq65p1PL
         sVyK3V8cLsn0mkRbDJzQUkvQ2fVzqBgaiu7ccT/+ewiLuDEm96HxRvUQ1/gs2wezWy
         tL22JChrMYkoKKSeR9c6gPwv18/GIg/psS+1LqYd5c5oN6h0mlXUL1GIF8nYN2HALe
         ku2HPHMg1vetN5eB0JE1bkbD1QF0c2H7zTfm9Zknr3LT0L47JlrdN18HCWjrQmjplH
         GrfKrj+F4MKSw==
Date:   Tue, 7 Jun 2022 17:25:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH Resend] xen/netback: do some code cleanup
Message-ID: <20220607172554.4b24d138@kernel.org>
In-Reply-To: <6507870c-1c32-ebf6-f85f-4bf2ede41367@suse.com>
References: <6507870c-1c32-ebf6-f85f-4bf2ede41367@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 07:28:38 +0200 Juergen Gross wrote:
> Remove some unused macros and functions, make local functions static.

> --- a/drivers/net/xen-netback/rx.c
> +++ b/drivers/net/xen-netback/rx.c
> @@ -486,7 +486,7 @@ static void xenvif_rx_skb(struct xenvif_queue *queue)
>    #define RX_BATCH_SIZE 64
>   -void xenvif_rx_action(struct xenvif_queue *queue)
> +static void xenvif_rx_action(struct xenvif_queue *queue)

Strange, I haven't seen this kind of corruption before, but the patch
certainly looks corrupted. It doesn't apply.
Could you "git send-email" it?

>   {

