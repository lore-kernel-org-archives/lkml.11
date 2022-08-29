Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13EC0502C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 13:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiH2NpM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiH2NpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9313D75;
        Mon, 29 Aug 2022 06:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3584760E74;
        Mon, 29 Aug 2022 13:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C23C433C1;
        Mon, 29 Aug 2022 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780707;
        bh=LONhSjhioPpIGkPhDqeNiVnudsZxe58m+isbUyEv7O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQ90tDo6HDoMD75jr6PWzAL/zAGSGfjhEqOa9lQtC/CpioFABRMhXsWPAVSEJ+yaG
         KKbofGAyw/tBUqYMgAPYqdIxHZ4E2hi1xpc6rI2PmQw03cRlxfHT+qGZw22AUrNwY0
         QwXMPWzCtqBP43ELOIl6zEj8v8HZpKOipp8/y5H+lfcuH0UWAbyTxe86o1Yj7fUkcO
         eqVvnTS7UCHGxVnQk9TxRNb+7c385AbuR6S0nsdx/74Jz8oUUvCoFiIV5TrR+DHIS+
         LlFDVWCtX6sa+wTBWu6INeEyjKs7WmcyPyU4iDKokp1xJQG/sQa6N3HgxeUhAHm1J/
         ssF49b2pqJWKA==
Date:   Mon, 29 Aug 2022 16:44:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     vbendel@redhat.com
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        Jozef Bacik <jobacik@redhat.com>
Subject: Re: [PATCH] docs: mm: fix vm overcommit documentation for
 OVERCOMMIT_GUESS
Message-ID: <YwzC01N62rtDvzQV@kernel.org>
References: <20220829124638.63748-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829124638.63748-1-vbendel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:46:38PM +0200, vbendel@redhat.com wrote:
> From: Vratislav Bendel <vbendel@redhat.com>
> 
> Commit 8c7829b04c52 "mm: fix false-positive OVERCOMMIT_GUESS failures"
> changed the behavior of the default OVERCOMMIT_GUESS setting.
> Reflect the change also in the Documentation, namely files:
>     Documentation/admin-guide/sysctl/vm.rst
>     Documentation/mm/overcommit-accounting.rst
> 
> Reported-by: Jozef Bacik <jobacik@redhat.com>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/sysctl/vm.rst    | 4 ++--
>  Documentation/mm/overcommit-accounting.rst | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 9b833e439f09..351443427360 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -742,8 +742,8 @@ overcommit_memory
>  
>  This value contains a flag that enables memory overcommitment.
>  
> -When this flag is 0, the kernel attempts to estimate the amount
> -of free memory left when userspace requests more memory.
> +When this flag is 0, the kernel compares the userspace memory request
> +size against total memory plus swap and rejects obvious overcommits.
>  
>  When this flag is 1, the kernel pretends there is always enough
>  memory until it actually runs out.
> diff --git a/Documentation/mm/overcommit-accounting.rst b/Documentation/mm/overcommit-accounting.rst
> index a4895d6fc1c2..e2263477f6d5 100644
> --- a/Documentation/mm/overcommit-accounting.rst
> +++ b/Documentation/mm/overcommit-accounting.rst
> @@ -8,8 +8,7 @@ The Linux kernel supports the following overcommit handling modes
>  	Heuristic overcommit handling. Obvious overcommits of address
>  	space are refused. Used for a typical system. It ensures a
>  	seriously wild allocation fails while allowing overcommit to
> -	reduce swap usage.  root is allowed to allocate slightly more
> -	memory in this mode. This is the default.
> +	reduce swap usage. This is the default.
>  
>  1
>  	Always overcommit. Appropriate for some scientific
> -- 
> 2.26.3
> 

-- 
Sincerely yours,
Mike.
