Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F39C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiHRRQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbiHRRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:16:12 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B78C0CD7B6;
        Thu, 18 Aug 2022 10:09:34 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27IGwdQV019170;
        Thu, 18 Aug 2022 11:58:39 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27IGwca8019169;
        Thu, 18 Aug 2022 11:58:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 18 Aug 2022 11:58:38 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, kuba@kernel.org,
        miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        asml.silence@gmail.com, imagedong@tencent.com,
        luiz.von.dentz@intel.com, vasily.averin@linux.dev,
        jk@codeconstruct.com.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: skb: prevent the split of kfree_skb_reason() by gcc
Message-ID: <20220818165838.GM25951@gate.crashing.org>
References: <20220816032846.2579217-1-imagedong@tencent.com> <CAKwvOd=accNK7t_SOmybo3e4UcBKoZ6TBPjCHT3eSSpSUouzEA@mail.gmail.com> <CADxym3Yxq0k_W43kVjrofjNoUUag3qwmpRGLLAQL1Emot3irPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3Yxq0k_W43kVjrofjNoUUag3qwmpRGLLAQL1Emot3irPQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Aug 19, 2022 at 12:31:44AM +0800, Menglong Dong wrote:
> On Wed, Aug 17, 2022 at 11:54 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Perhaps noipa might also work here?
> 
> In my testing, both 'noclone' and 'noipa' both work! As for the
> '-fdisable-ipa-fnsplit', it seems it's not supported by gcc, and I
> failed to find any documentation of it.

noipa is noinline+noclone+no_icf plus assorted not separately enablable
things.  There is no reason you would want to disable all
inter-procedural optimisations here, so you don't need noipa.

You need both noinline and no_icf if you want all calls to this to be
actual function calls, and using this specific function name.  If you
don't have noinline some calls may go missing (which may be fine for
how you use it).  If you don't have no_icf the compiler may replace the
call with a call to another function, if that does the same thing
semantically.  You may want to prevent that as well, depending on
exactly what you have this for.


Segher
