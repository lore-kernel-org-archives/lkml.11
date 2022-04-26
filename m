Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB26C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 12:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbiDZMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiDZMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7822C661
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A6A618B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33922C385A0;
        Tue, 26 Apr 2022 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650975161;
        bh=/nHfga5ufwcLpsGw6q0TSeoGPCo0q9qUdzsjCKj9DIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUywWPRMNTdwDZokT8Lp1pLoMeCcUuTdcfwX7O8bsAFDdrLDgWB6SWIFULLq4vFNa
         CUEb0dQHhUZkUOQm3D+QTOrHe2ubfchfab8bvrSjV8NvNOq7vLnWx5vEDCYLo46UCO
         XLy81qmvD+oMaCXn3mMKXvuZFjqKZWcMRAsKbw1U=
Date:   Tue, 26 Apr 2022 14:12:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jirislaby@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tty: n_gsm: return -EINVAL when adaption is not supported
Message-ID: <Ymfhtv5b9M33AQuc@kroah.com>
References: <20220426120554.1120585-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426120554.1120585-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:05:54AM -0400, Tom Rix wrote:
> The clang build fails with
> n_gsm.c:940:13: error: variable 'size' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         } else if (dlci->adaption == 2) {
>                    ^~~~~~~~~~~~~~~~~~~
> 
> The else should return an error, so return -EINVAL.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

What commit id does this fix?  Any reason you didn't cc: the author of
the recent changes to this code?

Is this the same issue that 0-day reported?

thanks,

greg k-h
