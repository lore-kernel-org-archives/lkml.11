Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322DFC25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 18:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiHQS2R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbiHQS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:28:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2F9AFCE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C1FCB81EAD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F485C433C1;
        Wed, 17 Aug 2022 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660760883;
        bh=CJxXwmMwa4XSWXmiHmDSo4nPBMEYTGgXVvfB3WCrsXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZ0flP8KtvIg3Jzxcwkes0sJBtRpGj8S954Sqp7+XPk538lqWtNGKSBXq08st3h6c
         TeZRbdhmY8HVdJkvYPMZ9zx3AO4YUwh7dJa3BCDVfkz7i8srw2M+ctWf9eE2kM1Zq1
         y4w8yDcNIYmH5GMElL2jOCisMtxRIO8+zY4zGUGw=
Date:   Wed, 17 Aug 2022 11:28:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: save LOC in vsyscall test
Message-Id: <20220817112802.29b92729e25313eeec2d44d3@linux-foundation.org>
In-Reply-To: <YvuDMGHcNtjhhMuq@bfoster>
References: <YvoWzAn5dlhF75xa@localhost.localdomain>
        <YvuDMGHcNtjhhMuq@bfoster>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 07:44:48 -0400 Brian Foster <bfoster@redhat.com> wrote:

> On Mon, Aug 15, 2022 at 12:50:04PM +0300, Alexey Dobriyan wrote:
> > From: Brian Foster <bfoster@redhat.com>
> > 
> > Do one fork in vsyscall detection code and let SIGSEGV handler exit and
> > carry information to the parent saving LOC.
> > 
> > 	[
> > 		redo original patch,
> > 		delete unnecessary variables,
> > 		minimise code changes.
> > 					--adobriyan
> > 	]
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> 
> LGTM and passes my quick tests, thanks!
> 
> FWIW:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

It would be appropriate for us to include your Signed-off-by.  Please
send one along?

