Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 11:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388801AbiDULgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDULgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:36:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B935140DA;
        Thu, 21 Apr 2022 04:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1894CB8242A;
        Thu, 21 Apr 2022 11:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41869C385A1;
        Thu, 21 Apr 2022 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650540804;
        bh=ao0jMxcQuAliYHBIwmQDRw2VwZJxu6dlSX7UzydhnDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsgJTKBCPKLuqT319Erff42n6vwFQPA5KxZhUKzKb+XWzHvBnVNtfkKxTGoKUmxXf
         2lVHICZgT47SKGZCo4sRy6DBKPPUU5XV/wbjyIbsk0ocQoC1Z1iBZsFV1pRRXBQPi7
         a5p/O+F1BNPbCZezIxnPPKePFsuSauHRfm2lFYKw=
Date:   Thu, 21 Apr 2022 13:33:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fu Zixuan <r33s3n6@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] drivers: usb: host: fix NULL pointer dereferences
 triggered by unhandled errors in xhci_create_rhub_port_array()
Message-ID: <YmFBAcgrJ2NIKctS@kroah.com>
References: <20220421094236.1052170-1-r33s3n6@gmail.com>
 <YmEs6BqcyM7fgLXg@kroah.com>
 <CAMvdLAPR6JN6PqL_z+MwR=kB5o=+ydBbast9Q-Zgzt_Hwt+UJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMvdLAPR6JN6PqL_z+MwR=kB5o=+ydBbast9Q-Zgzt_Hwt+UJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:29:30PM +0800, Fu Zixuan wrote:

<snip>

For some reason you sent this in html format, and top-posted, making
this not show up on the mailing lists.  Please fix your email client and
resend and I will be glad to respond.

thanks,

greg k-h
