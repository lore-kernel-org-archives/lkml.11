Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6BCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiDMWAy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiDMWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:00:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7365289A6;
        Wed, 13 Apr 2022 14:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC8BB8278B;
        Wed, 13 Apr 2022 21:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E193FC385A6;
        Wed, 13 Apr 2022 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649887103;
        bh=3Qp8VakLhp3AT/Ltza7kSfd4UrLpvGlIXVTq7iBxA8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aF8OBacYw1Ms5OVAjVzXxx6KgYYxb/1BZB3jCWeUnCB8KA7bffTAKkSeH0cVuJ22/
         6UmkqmLYf+hz0ToBjepct5ZaaApTiGxj1t8k83I/hcFKUbX7ePjIPK1w3habU3Svj8
         boJXaAjvp2rcDvsulnXI6+SrFswlNcUdgo8wOF+ygofQ9kwrVtmVOwTYLH0UhMa81K
         NbZWRNsVMYcDRWI15/BaMpa7OnIR+gXfFb3XdI9a+iYmXGEjFWPX9n/7UIBR6iByUz
         dUpMV0IImVZKmAavYWbwJ7xXbjd4CnHXjZRa20oqMoJwbdd97pwaqjq9D0I2cgRD4O
         tU53Ghmzf6QlA==
Date:   Wed, 13 Apr 2022 14:58:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <YldHfXQCUzb3ZqG3@google.com>
References: <20220414074156.2c454505@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414074156.2c454505@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   4b6857882c90 ("f2fs: remove obsolete whint_mode")
> 
> Fixes tag
> 
>   Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks, fixed.

> 
> -- 
> Cheers,
> Stephen Rothwell


