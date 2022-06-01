Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5920C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 19:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiFAToJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiFAToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3C1C422A;
        Wed,  1 Jun 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHZbbhlnwWZ69g/BbqnWHLaBADjVX+Zh/qnzxYzNDO0=; b=ZNJxRbKgkoPIU1PbhayK20lWOc
        zOSaeGjel+0cbGqgoSDF11BVPSMGnRo8bprJpkGZ2+dJtXT2naYo3XMWNtJmWTSHzYNI/4nvtN/Lr
        VsXtpggm5OqGtC/wucz4NIl3gjx0JHwtsUE+kPP/doftwrxGhsJNAJOULb8nBEI3/8xzjqC+hBEtx
        cJSyr0Gc7Fh2FH7QVhUIcOXwrbc7suIjM+CMImaLrBCGtFcA5LgII3aIWcQyMor0+aWBMDQ/WDv3Z
        ks8YO6RtOc1uaI3LGcnKTMzKBBdn5NPc+AU7hIJH1jQh6tTdoo3uYMah2s8KsGMUmubimxRXN5/tN
        CcK/NSLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwTsA-006XqD-2w; Wed, 01 Jun 2022 19:19:14 +0000
Date:   Wed, 1 Jun 2022 20:19:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [RFC PATCH 1/4] sysctl: API extension for handling sysctl
Message-ID: <Ype7skNJzEQ1W96v@casper.infradead.org>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org>
 <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:20:29PM +0200, Alexey Gladkov wrote:
> +struct ctl_fops {
> +	int (*open) (struct ctl_context *, struct inode *, struct file *);
> +	int (*release) (struct ctl_context *, struct inode *, struct file *);
> +	ssize_t (*read) (struct ctl_context *, struct file *, char *, size_t *, loff_t *);
> +	ssize_t (*write) (struct ctl_context *, struct file *, char *, size_t *, loff_t *);
> +};

Why not pass the iocb in ->read and ->write?  We're still regretting not
doing that with file_operations.
