Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701DFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 03:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiBXDfX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 22:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBXDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:35:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573222A281;
        Wed, 23 Feb 2022 19:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4CAFB81FCD;
        Thu, 24 Feb 2022 03:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3009C340EF;
        Thu, 24 Feb 2022 03:34:50 +0000 (UTC)
Date:   Wed, 23 Feb 2022 22:34:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Oscar Shiang <oscar0225@livemail.tw>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove duplicated words in trace/osnoise-tracer
Message-ID: <20220223223448.61dcdb3e@rorschach.local.home>
In-Reply-To: <9531b09c-6dc2-f551-d699-29b0c8cc2aeb@kernel.org>
References: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
        <9531b09c-6dc2-f551-d699-29b0c8cc2aeb@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 21:43:29 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 2/20/22 13:12, Oscar Shiang wrote:
> > There are 2 duplicated words found in osnoise tracer documentation.
> > This patch removes them.
> > 
> > Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>  
> 
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Jon, want to take this through your tree?

Thanks,

-- Steve

