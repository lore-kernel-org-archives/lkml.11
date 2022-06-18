Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCBC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiFRJfr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jun 2022 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiFRJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:35:42 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F0F19C2C;
        Sat, 18 Jun 2022 02:35:40 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:35:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655544939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRqSy6SjNdTOFK38p5f7a9N5x5zhkPypJUAO4+ClytQ=;
        b=vUoX+QYUXkK9pwFrFax8w6XHxvLcbLSNAeAr4U5qlG2daEyqUd/pzIOvxwwVHSEaEH1XBT
        07xOGGHzGhHLS5XAdfLIlfRFNWTIGqUM6LO+8wdi9G7DmgmjMK6oQSGtgvPPvPI3b5XkYR
        O1ooDhGGkCDSQFX/iN5+zjseYFYbxPE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Fanjun Kong <fanjun.kong@linux.dev>
To:     songmuchun@bytedance.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, bh1scw@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sysctl.c: Clean up indentation, replace spaces
 with tab.
Message-ID: <20220618093534.fjbjtlbn3eqztphu@kong-Standard-PC-i440FX-PIIX-1996>
References: <20220522052933.829296-1-bh1scw@gmail.com>
 <20220618091519.bfjbm4ifxpbx7yep@kong-Standard-PC-i440FX-PIIX-1996>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220618091519.bfjbm4ifxpbx7yep@kong-Standard-PC-i440FX-PIIX-1996>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 6月 22 ◦ 17:15, Fanjun Kong wrote:
> Hi maintainer,
> 
> Could you help to review this patch? 
I am so sorry for my last email, I have not noticed Luis has already helped
me because I just switch my email from gmail to linux.dev.

Best wishes.

> 
> Thanks so much.
> 
> On 22 May 22 ◦ 13:29, bh1scw@gmail.com wrote:
> > From: Fanjun Kong <bh1scw@gmail.com>
> > 
> > This patch fixes two coding style issues:
> > 1. Clean up indentation, replace spaces with tab
> > 2. Add space after ','
> > 
> > Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
> > ---
> >  kernel/sysctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index e52b6e372c60..de8da34e02a5 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1277,8 +1277,8 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
> >  int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
> >  				 void *buffer, size_t *lenp, loff_t *ppos)
> >  {
> > -    return do_proc_dointvec(table,write,buffer,lenp,ppos,
> > -		    	    do_proc_dointvec_userhz_jiffies_conv,NULL);
> > +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
> > +				do_proc_dointvec_userhz_jiffies_conv, NULL);
> >  }
> >  
> >  /**
> > -- 
> > 2.36.0
> > 
