Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA520CCA47B
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jul 2022 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiGQRIo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jul 2022 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiGQRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:08:41 -0400
Received: from relay4.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2D13FA0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:08:40 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 05C8F332F2;
        Sun, 17 Jul 2022 17:08:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id EB8BA2002C;
        Sun, 17 Jul 2022 17:08:37 +0000 (UTC)
Message-ID: <59c0003bfc5b429a8e39151da942fcaf707109a0.camel@perches.com>
Subject: Re: [PATCH] iio: Use parens with sizeof
From:   Joe Perches <joe@perches.com>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 17 Jul 2022 10:08:37 -0700
In-Reply-To: <20220717153438.10800-1-joetalbott@gmail.com>
References: <20220717153438.10800-1-joetalbott@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: EB8BA2002C
X-Stat-Signature: 9911izepj39zp17qhzhwt613c9zcroyy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nx1ElYkqWpTP61kVIPONgx3PEo2wyg7w=
X-HE-Tag: 1658077717-965248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-17 at 11:34 -0400, Joe Simmons-Talbott wrote:
> Prefer 'sizeof(var)' over 'sizeof var' as reported by checkpatch.pl.

unrelated trivia:

> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
[]
> @@ -368,7 +368,7 @@ struct iio_poll_func
>  	va_list vargs;
>  	struct iio_poll_func *pf;
>  
> -	pf = kmalloc(sizeof *pf, GFP_KERNEL);
> +	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
>  	if (pf == NULL)
>  		return NULL;
>  	va_start(vargs, fmt);
> @@ -560,7 +560,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  	struct iio_trigger *trig;
>  	int i;
>  
> -	trig = kzalloc(sizeof *trig, GFP_KERNEL);
> +	trig = kzalloc(sizeof(*trig), GFP_KERNEL);
>  	if (!trig)
>  		return NULL;

It'd be nice to be consistent with the allocation return test.

Please pick one of:

	if (ptr == NULL)
or
	if (!ptr)		// my preference

