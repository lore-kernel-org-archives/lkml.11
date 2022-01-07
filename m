Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C43C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jan 2022 06:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiAGGrz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jan 2022 01:47:55 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60106 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAGGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:47:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46758)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5j2S-00G7H9-E7; Thu, 06 Jan 2022 23:47:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:34768 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5j2Q-001kgS-V6; Thu, 06 Jan 2022 23:47:48 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-kernel@vger.kernel.org
References: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
Date:   Fri, 07 Jan 2022 00:47:18 -0600
In-Reply-To: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
        (Hongchen Zhang's message of "Fri, 7 Jan 2022 12:45:57 +0800")
Message-ID: <878rvsyrd5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5j2Q-001kgS-V6;;;mid=<878rvsyrd5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mKt1SOkelGD15NWOL4cj4PerHwQOKNrQ=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: strict valid signal check
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hongchen Zhang <zhanghongchen@loongson.cn> writes:

> The max usable signal number is limited by both _NSIG and task's
> exit_code, and the max valid signal number encoded in task's
> exit_code is 127. On the other hand _NSIG is normally power of 2,
> so limit the rule in valid_signal to check a valid signal number.

A quick look reveals this only affects mips.

If you have copied that silliness from mips for your new architecture
I would advise against it.  That just seems to make sigset_t twice
as big as it needs to be for no good reason.

What seems reasonable is to fix mips to only support 127 signals (with
the same sigset_t size) and to add "BUILD_BUG_ON(_NSIG <= 127);" along
with your comment somewhere in kernel/signal.c

Eric


> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  include/linux/signal.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index a6db6f2..9f1972e 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -270,7 +270,11 @@ static inline void init_sigpending(struct sigpending *sig)
>  /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
>  static inline int valid_signal(unsigned long sig)
>  {
> -	return sig <= _NSIG ? 1 : 0;
> +	/* max usable signal number is limited by both _NSIG and task's
> +	 * exit_code, and the max available signal number encoded in
> +	 * task's exit_code is 127.
> +	 */
> +	return sig <= min(_NSIG, 127) ? 1 : 0;
>  }
>  
>  struct timespec;
