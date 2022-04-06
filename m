Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD35C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiDFPtL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiDFPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E255348B58;
        Wed,  6 Apr 2022 06:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9543261BE2;
        Wed,  6 Apr 2022 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78763C385A3;
        Wed,  6 Apr 2022 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649250282;
        bh=pg/2MkpNnzjv5CVzDKTAf71fbhHWkr8Xyd8iEp35Khc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlLnH5OzioJgnW5RgaR7ACr0FYOwiGaEMeRuL/di7AZA60GzoUPAId8M+TfDVfQP8
         TOIIxq69VbjHB6+7a+g5qhTsSWx4XGHxH9r8u72tn38NriTEIKMJ3hEjAiiqSPHGdt
         znPorIKAV78v14N7d3fk/d3h/ZLFj9mMx+V5SIWM=
Date:   Wed, 6 Apr 2022 15:04:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 327/913] lib: uninline simple_strntoull() as well
Message-ID: <Yk2P58P53btqLAgr@kroah.com>
References: <20220405070339.801210740@linuxfoundation.org>
 <20220405070349.652301661@linuxfoundation.org>
 <Yk2I7JXzXaXi+6R1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk2I7JXzXaXi+6R1@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:34:52PM +0300, Alexey Dobriyan wrote:
> On Tue, Apr 05, 2022 at 09:23:09AM +0200, Greg Kroah-Hartman wrote:
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > 
> > [ Upstream commit 839b395eb9c13ae56ea5fc3ca9802734a72293f0 ]
> > 
> > Codegen become bloated again after simple_strntoull() introduction
> > 
> > 	add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-224 (-224)
> 
> > -static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
> > -					   char **endp, unsigned int base)
> > +static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
> 
> This patch doesn't fix any bugs, why it is selected?

Easy change to make the kernel a tiny bit smaller?


