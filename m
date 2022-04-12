Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355788AbiDLNnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356185AbiDLNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B349242
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CAF618F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C8DC385A5;
        Tue, 12 Apr 2022 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649770835;
        bh=lmjMi2JL1E2d3tXC8QaScWD0jdPvNz82ZBYIoK79yxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2WLv5bUdYLIeaoKiAgXwsydDMqLl68I2CfQFgk/b6cUdTjIb9IVtggtAviE6uaoa
         BP7JAPtc5iGgI0LHYGQYGRuuVyCjxz822eCqicL/f5XYqoNr9jfBWtF/YrLvT+a0ui
         zQle3qVLQLc3gpwUxgR0TZXKY+WCTZYGN/+ahU58=
Date:   Tue, 12 Apr 2022 15:40:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] staging: vt6655: Replace VNSvOutPortB with
 iowrite8
Message-ID: <YlWBUGBY6mdjM9iH@kroah.com>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
 <3cac1ca7000a56e82b390ea0ddbab5aa549ee7ec.1649706687.git.philipp.g.hortmann@gmail.com>
 <20220412063731.GA3293@kadam>
 <25a1bac5-7758-9602-7c9f-9d8b02d845e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a1bac5-7758-9602-7c9f-9d8b02d845e4@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:45:53AM +0200, Philipp Hortmann wrote:
> On 4/12/22 08:37, Dan Carpenter wrote:
> > On Mon, Apr 11, 2022 at 10:49:39PM +0200, Philipp Hortmann wrote:
> > > Replace macro VNSvOutPortB with iowrite8.
> > > The name of macro and the arguments use CamelCase which
> > > is not accepted by checkpatch.pl
> > > 
> > > For constants from 0 to below 0x80 the u8 cast was omitted.
> > > For variables which are defined as unsigned char the u8 is omitted.
> > I hate that GCC prints warnings for this.  Useless.  Horrible.  But I
> > understand that GCC does and we haven't figured out how to disable it
> > or who needs to approve that.
> > 
> > But even then I still don't understand the casting in this patch.
> > 
> > Shouldn't the rule be to do the minimum work arounds to silence GCC?
> > My understand is that the the casting is only needed when you're dealing
> > with a bitwise negated constant.  These are macros so the parameters
> > might be constant so basically any bitwise negate gets a cast.
> > 
> 
> Please send me the compiler flags you are using.
> I was using:
> make "KCFLAGS=-pipe -Wall" -C . M=drivers/staging/vt6655/

Why are you adding random flags to the build?  Just stick with the
default ones, that's all you need.

thanks,

greg k-h
