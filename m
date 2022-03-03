Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 13:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiCCNKl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiCCNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:10:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F18186437
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:09:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B14DDCE2541
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8994EC004E1;
        Thu,  3 Mar 2022 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646312989;
        bh=L5rgshl6gX3zP6AuSBghYIYNUi7nQdU7yZUuh35MOY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARl4yKSZhU5eWD8g74hZx+5N3vyzsc8AyO4D6zj23jX0sq1cA1XLFOnsoyZHE6PnR
         mOtC4YU5JRZUl+uCAwWY+VABZ6TEFccoxmqTHDkm/mBv1+/evuC7pCM8YDQrKY4Y13
         ekTADmlbMWHfEaA0DZ6nerzFfD9jsoAI1cy6LxEY=
Date:   Thu, 3 Mar 2022 14:09:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of
 snprintf
Message-ID: <YiC+G4069cIFqHfO@kroah.com>
References: <20220302120759.380932-1-phind.uet@gmail.com>
 <Yh+EdGcsoF+lBjfX@kroah.com>
 <32164620-9ba6-db62-bc61-95c7f255d087@gmail.com>
 <Yh/SGeW1KPcbH4ob@kroah.com>
 <4f3310b4-beab-9b5f-0cd4-f530559aa470@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3310b4-beab-9b5f-0cd4-f530559aa470@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:45:07PM +0800, Phi Nguyen wrote:
> On 3/3/2022 4:22 AM, Greg KH wrote:
> Am I right in thinking that you are the maintainer of these files?

Yes, I think so.

> Can I send a patch to add an entry to /linux/MAINTAINERS file?

Please do.

thanks,

greg k-h
