Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 09:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiCJJUI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiCJJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A313913C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9A961C64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3AAC36AF4;
        Thu, 10 Mar 2022 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646903944;
        bh=OhpNF8WViNL36unydTb9lJvXpzj1iKydclWlldKejA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+mo8Ku6PDmkuYG+dP+vMfeZVH4RSVdYuglzgukjP7KGC6+WpTWKEedCc3JAJFNqN
         eOmr/iCfygmbKi/ml0lM6KYErYaVJHt3zhhABlLV0seUR5UJaI7nd1LbPMeSZaiWD6
         Tw98ZEIKZiCCXIZOb6KjHGnCX2UDknr54dhcgRtE=
Date:   Wed, 9 Mar 2022 19:33:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        bryantan@vmware.com, rjalisatgi@vmware.com
Subject: Re: [PATCH] VMCI: Fix a couple of failure paths in
 vmci_guest_probe_device()
Message-ID: <Yijy5miaTI3GIXDZ@kroah.com>
References: <1646850296-49445-1-git-send-email-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646850296-49445-1-git-send-email-vdasa@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:56AM -0800, Vishnu Dasa wrote:
> notification_bitmap may not be released when VMCI_CAPS_DMA_DATAGRAM
> capability is missing from the device.  Add missing
> 'err_free_notification_bitmap' label and use it instead of
> 'err_free_data_buffers' to avoid this.
> 
> free_irq() may be called to free an interrupt that was not
> allocated.  Add missing 'if' statement to check for
> exclusive_vectors when freeing interrupt 1.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
> The patches which introduced these bugs are not in any released
> kernels nor RC yet, so this fix does not need to be backported.

So this has to get into 5.17-final?  If not, it should be backported to
5.17, right?  You should always include the "Fixes:" tag in the commit
message so that we can figure this out.

And shouldn't this be 2 different patches?  Please break up.

thanks,

greg k-h
