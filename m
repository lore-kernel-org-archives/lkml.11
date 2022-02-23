Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C481DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 00:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiBWABV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiBWABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:01:20 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CD1D4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:00:53 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:34536)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMf5P-00Gru7-Fr; Tue, 22 Feb 2022 17:00:51 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:51350 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMf5N-00G58W-IT; Tue, 22 Feb 2022 17:00:50 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     xu xin <cgel.zte@gmail.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        balbir@linux.vnet.ibm.com, xu.xin16@zte.com.cn,
        Linux Containers <containers@lists.linux.dev>
References: <20220217093945.1904085-1-xu.xin16@zte.com.cn>
        <20220221032202.1925507-1-xu.xin16@zte.com.cn>
Date:   Tue, 22 Feb 2022 18:00:42 -0600
In-Reply-To: <20220221032202.1925507-1-xu.xin16@zte.com.cn> (xu xin's message
        of "Mon, 21 Feb 2022 03:22:02 +0000")
Message-ID: <87v8x678ph.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nMf5N-00G58W-IT;;;mid=<87v8x678ph.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19QOxAXvj0mBgOUQkTk4AIyjG4Lz6zcAgQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH resend] kernel: Make taskstats available via genetlink
 per namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xu xin <cgel.zte@gmail.com> writes:

> Currently, the application getdelays cannot get taskstats in a net
> namespace. The returned error is just like the following:
> -sh-4.4# ps -ef | tail -5
> root       186     2  0 09:23 ?        00:00:00 [kworker/2:1H]
> root       187     2  0 09:23 ?        00:00:00 [kworker/0:2-eve]
> root       190   183  0 09:23 ?        00:00:00 -sh
> root       198   190  0 09:25 ?        00:00:00 ps -ef
> root       199   190  0 09:25 ?        00:00:00 tail -5
> -sh-4.4#
> -sh-4.4# ./getdelays -d -p 186 -v
> print delayacct stats ON
> debug on
> Error getting family id, errno 0
>
> As more and more applications are deployed in containers like Docker,
> it is necessary to support getdelays to be used in net namespace.
> Taskstats is safe for use per namespace as genetlink checks the
> capability of namespace message by netlink_ns_capable().
>
> Make taskstats available via genetlink per namespace.

Let me add a polite nack to this patch.

Taskstats is completely senseless in a network namespace.  There is no
translation of identifiers into the context of the receiver of the
message.

As such taskstats can not be meaningfully used in a container.

To make this work requires updating the taskstats code to do something
sensible when in a pid namespace, as well as when in a network
namespace.

I would like to give a suggest on how to do something sensible but
I don't have any idea at this point.  The code would have been converted
long ago on general principles if this was a straight forward thing to
do.

The taskstats interface only makes sense when you are within all of the
initial namespaces.

Eric

> Reported-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  kernel/taskstats.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 2b4898b4752e..4d6bcaaf52a0 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -664,6 +664,7 @@ static struct genl_family family __ro_after_init = {
>  	.module		= THIS_MODULE,
>  	.ops		= taskstats_ops,
>  	.n_ops		= ARRAY_SIZE(taskstats_ops),
> +	.netnsok	= true,
>  };
>  
>  /* Needed early in initialization */
