Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3FC38161
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351304AbiEAQ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352126AbiEAQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:54:32 -0400
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2F23146;
        Sun,  1 May 2022 09:50:48 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 7F1372963C;
        Sun,  1 May 2022 16:50:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 6AA5820027;
        Sun,  1 May 2022 16:50:46 +0000 (UTC)
Message-ID: <8cf3b100a4dc0eaac9214e1a9ea2b6dace7c85bb.camel@perches.com>
Subject: Re: [PATCH] USB / dwc3: remove a possible unnecessary 'out of
 memory' message
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kushagra Verma <kushagra765@outlook.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 May 2022 09:50:45 -0700
In-Reply-To: <Ym6pp/O1fpneA5ZW@kroah.com>
References: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
         <Ym6pp/O1fpneA5ZW@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ocn1kks8g9de1t4exx157enah9yc3p9u
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6AA5820027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19RJa68z0JhzR0knFOtfVGBO3/AWAtbFCU=
X-HE-Tag: 1651423846-659880
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-01 at 17:39 +0200, Greg KH wrote:
> On Sun, May 01, 2022 at 09:01:36PM +0530, Kushagra Verma wrote:
> > This patch removes a possible unnecessary out of memory message from
> > core.c
> > as reported by checkpatch.pl:
> >    WARNING: Possible unnecessary 'out of memory' message


> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/email-clients.txt in order to fix this.

Seems like a patch-bot false positive patch-bot to me.

