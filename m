Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BBEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbiD1PtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiD1PtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175010E1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFB261F94
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F236C385A0;
        Thu, 28 Apr 2022 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651160754;
        bh=jlixZfnqmKwsIrnN9lsthFcR9XPCemSMhABH6wF5Vak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ckfl7IiSrlKHBmTeTl558CK6CyJAsU1xYpPEtird+WEKuZGZKLJvgpQmzIv9iWu7d
         PRLSIIojMl9MyOjlMrHEMuhr/f4XrTZQbtNwP7RcZb5wwFQB8qK9+5QNa32JjjUgy6
         SUjX6eeRPaoaXtvlA0tqf9Zdh2SbZM79fJJvYajU=
Date:   Thu, 28 Apr 2022 17:45:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vchiq_arm: use standard print helpers
Message-ID: <Ymq2rw3yn8m0t+oe@kroah.com>
References: <20220428150550.261499-1-athierry@redhat.com>
 <YmqxZevQJpWuLlQ3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqxZevQJpWuLlQ3@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:23:17PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 28, 2022 at 11:05:49AM -0400, Adrien Thierry wrote:
> > Replace the custom debug print macros with the standard dev_err() and
> > friends.
> > 
> > This handles TODO item "Cleanup logging mechanism".
> > 
> > Signed-off-by: Adrien Thierry <athierry@redhat.com>
> > ---
> > 
> > Changes since v1: removed function name in dev_dbg() calls
> > 
> >  .../interface/vchiq_arm/vchiq_arm.c           | 157 +++---
> >  .../interface/vchiq_arm/vchiq_connected.c     |   7 +-
> >  .../interface/vchiq_arm/vchiq_connected.h     |   4 +-
> >  .../interface/vchiq_arm/vchiq_core.c          | 495 ++++++++----------
> >  .../interface/vchiq_arm/vchiq_core.h          |  43 +-
> >  .../interface/vchiq_arm/vchiq_debugfs.c       | 105 ----
> >  .../interface/vchiq_arm/vchiq_dev.c           |  86 ++-
> >  7 files changed, 341 insertions(+), 556 deletions(-)
> 
> Try doing this in smaller chunks.  There's a lot of churn here, and not
> all of it is correct.
> 
> Try removing these one-function-at-a-time and then when it's all
> finished, you can remove the debugfs and function calls as no one is
> calling them.

That is one function you are replacing at a time, not to do this one
function you are cleaning up in the source at a time.  If that makes
sense.  Awkward wording...

