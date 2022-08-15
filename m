Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C9C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiHOUSt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346815AbiHOUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:12:22 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3A85FA3;
        Mon, 15 Aug 2022 11:58:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oNfI6-00008a-6K; Mon, 15 Aug 2022 20:58:22 +0200
Date:   Mon, 15 Aug 2022 20:58:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 154/779] netfilter: nf_tables: add rescheduling
 points during loop detection walks
Message-ID: <20220815185822.GA26513@breakpoint.cc>
References: <20220815180337.130757997@linuxfoundation.org>
 <20220815180343.899696572@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815180343.899696572@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> [ Upstream commit 81ea010667417ef3f218dfd99b69769fe66c2b67 ]
> 
> Add explicit rescheduling points during ruleset walk.

NAK.  There is a partial revert pending.

> @@ -9225,9 +9227,13 @@ static int nf_tables_check_loops(const struct nft_ctx *ctx,
>  				break;
>  			}
>  		}
> +
> +		cond_resched();
>  	}
>  
>  	list_for_each_entry(set, &ctx->table->sets, list) {
> +		cond_resched();

Can't be used here, this can be called from atomic context.
