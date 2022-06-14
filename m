Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F50C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiFNJed (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFNJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26109369D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7F4B616BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A60C3411E;
        Tue, 14 Jun 2022 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655199269;
        bh=IYgQG9blIoKzvbPB3jEd8z1QwKJ/w1HafluWp4ktkPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pR1Pg2HJJP7c+DzXAzcoYxcbReVYpqU1F1ZeO3AOqMUsjPCJ6I7c3KAbriJi8obk/
         9egLJjb1otwqHAkrfFUWftpVbqduUNO7Q/30QLcyYo7SKxVItHT0A0Wae0gUogMFCD
         M0rMjEJGa0sB2ZeH9W7eOByEUiQBvlWU5MQtVOWM=
Date:   Tue, 14 Jun 2022 11:34:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nam Cao <namcaov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, phil@philpotter.co.uk
Subject: Re: [PATCH v2 1/2] staging: r8188eu: replace LE_BITS_TO_1BYTE with
 clearer codes
Message-ID: <YqhWIiXadDC3hzel@kroah.com>
References: <cover.1655019752.git.namcaov@gmail.com>
 <4cdacd703158029c0b0f706e3cf1eb8daf4121c0.1655019752.git.namcaov@gmail.com>
 <20220613143024.GE2146@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613143024.GE2146@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:30:24PM +0300, Dan Carpenter wrote:
> On Sun, Jun 12, 2022 at 10:11:43AM +0200, Nam Cao wrote:
> > The statement LE_BITS_TO_1BYTE(__paddr + n, 0, 8) is not obvious on
> > what it is doing, while in truth it is simply reading one byte.
> > Replace these with clearer codes.
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> > index 20d73ca781e8..79e4210c6b65 100644
> > --- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> > +++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> > @@ -26,15 +26,15 @@
> >  #define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
> >  	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
> >  #define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
> > -	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
> > +	((u8 *)__paddr)[2]
> 
> Instead of doing this, I would prefer to just get rid of
> GET_TX_REPORT_TYPE1_RERTY_[1234].

Yes, I agree, that's a mess and almost impossible to understand...

thanks,

greg k-h
