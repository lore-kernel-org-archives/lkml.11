Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3920C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 17:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353576AbiBURIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:08:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbiBURIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:08:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6325C68
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BABE61389
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9EDC340E9;
        Mon, 21 Feb 2022 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463290;
        bh=Cqf3AC3eSmksXRrgwQuVSn+GrWz4xbmD0KUGWZu8Z1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ck1dHcXUtX30MIGN5IAkKx9/xsoxV2QAOjoG8sIaVxm+vMf3Cp6YkRy5qLy9PCUS4
         41K87X/Ol7uq5cIY7/t+3WWyza/RpFPolEi7djRUT8ReqYG03j1banIcg3GFgSWhFB
         Wpr/Yrqc02FS2rO0znl5PbmPL3QyNpQKEYEGlfh4=
Date:   Mon, 21 Feb 2022 18:08:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHECK: Lines should not end with a '(' + retval =
 ms_transfer_tpc(
Message-ID: <YhPG+CwuWtm4sPgo@kroah.com>
References: <20220219003323.257781-1-info@samuelsjoberg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220219003323.257781-1-info@samuelsjoberg.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 01:33:23AM +0100, Samuel Sjöberg wrote:
> Signed-off-by: Samuel Sjöberg <info@samuelsjoberg.se>
> ---
>  drivers/staging/rts5208/ms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Your subject line is very odd :(

Please fix up and also provide a real changelog text as the
documentation asks for.

thanks,

greg k-h
