Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63745C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiFWQWX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiFWQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD03A180;
        Thu, 23 Jun 2022 09:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2D8B8247D;
        Thu, 23 Jun 2022 16:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAF6C3411B;
        Thu, 23 Jun 2022 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656001337;
        bh=YsoOAuqQs9dQOMHE2o4hFP7F/IQj/Aa/1OiV4zxOfJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rx4h6HYI0upiTLUuiAH06O5d9LWGE4od0bd8WR+5RsXZUqdZxy49KzUSjzcbgH8Mj
         MjElvwJO2Y+QwwnM947MOOVkfdyac5rpOROJAAaT9Gt3g1lZcQhiylgfiOeEakUn07
         yUhUOeJNuSttz2BZC8NHc5W4TAVVI+nTTMYHFLcv4E2iOwHDbCIJX3kxpx7qlJABm8
         +OUqgSAdE59V8zHW/HO1360g25aiRJk+f/fUho4v+fER1VrAQNTyl5mUWLyxkxCXLa
         s0gwXu8nq+hqNuwCIekgWs3SX/HBVuntfdy/cqo25InD2DgJ7tZdEPePgzkVyibJQf
         IQxXp1zdJ3MfQ==
Date:   Thu, 23 Jun 2022 09:22:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        idosch@nvidia.com, petrm@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: drop unexpected word 'for' in comments
Message-ID: <20220623092208.1abbd9dc@kernel.org>
In-Reply-To: <20220623104601.48149-1-jiangjian@cdjrlc.com>
References: <20220623104601.48149-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 18:46:01 +0800 Jiang Jian wrote:
> file - drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
> line - 18
> 
> 	 * ids for for this purpose in partition definition.
> changed to:
> 
> 	 * ids for this purpose in partition definition.

Please stop putting the change into the description.
I think I already complained about this.
This is exactly the same information as is in the patch itself.

And as other people have pointed out - please say that the word
is repeated not "unexpected".

IDK why you made those changes because your patches on Wednesday 
where better:

  [PATCH] bnxt: Fix typo in comments

  Remove the repeated word 'and' from comments

  Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

https://lore.kernel.org/r/20220622144526.20659-1-jiangjian@cdjrlc.com/

I'm dropping these patches from you, please redo them:

  https://patchwork.kernel.org/project/netdevbpf/patch/20220623104919.49600-1-jiangjian@cdjrlc.com/
  https://patchwork.kernel.org/project/netdevbpf/patch/20220622171711.6969-1-jiangjian@cdjrlc.com/
  https://patchwork.kernel.org/project/netdevbpf/patch/20220623104601.48149-1-jiangjian@cdjrlc.com/
