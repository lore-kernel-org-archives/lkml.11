Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90585C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Mar 2022 19:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbiCTTSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiCTTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 15:17:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97EB8D3AF3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 12:16:34 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22KJGJcQ027355;
        Sun, 20 Mar 2022 20:16:19 +0100
Date:   Sun, 20 Mar 2022 20:16:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH v1 2/6] tools/nolibc: Make the entry point not weak
 for clang
Message-ID: <20220320191619.GA27312@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-3-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320093750.159991-3-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

I've had a look at this one.

On Sun, Mar 20, 2022 at 04:37:46PM +0700, Ammar Faizi wrote:
> Budilig with clang yields the following error:
  ^^^^^^^
BTW please fix the typo in the final commit message.

> @@ -183,7 +183,9 @@ struct sys_stat_struct {
>  
>  /* startup code */
>  asm(".section .text\n"
> +#if !defined(__clang__)
>      ".weak _start\n"
> +#endif
>      ".global _start\n"
>      "_start:\n"

So it seems that I was wrong and that .weak is an alternate for .global
and not a complement. As such, instead of adding all these #if, please
simply remove all .global.

Thanks!
Willy
