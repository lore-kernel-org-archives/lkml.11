Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0EAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 16:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiGYQQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:16:42 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52513FBB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:16:42 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38100)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG0l6-003w3H-H7; Mon, 25 Jul 2022 10:16:40 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:58050 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG0l5-006JxI-Hs; Mon, 25 Jul 2022 10:16:40 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
References: <54e6b6b1b430537748a7136e854923498443f78a.1657642613.git.legion@kernel.org>
Date:   Mon, 25 Jul 2022 11:16:07 -0500
In-Reply-To: <54e6b6b1b430537748a7136e854923498443f78a.1657642613.git.legion@kernel.org>
        (Alexey Gladkov's message of "Tue, 12 Jul 2022 18:17:38 +0200")
Message-ID: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oG0l5-006JxI-Hs;;;mid=<87wnc1i2wo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+7xsvv3hql2OPojijov5d5m6fwK6evo0A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1] sysctl: Allow change system v ipc sysctls inside ipc
 namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Rootless containers are not allowed to modify kernel IPC parameters such
> as kernel.msgmnb.
>
> It seems to me that we can allow customization of these parameters if
> the user has CAP_SYS_RESOURCE in that ipc namespace.
>
> CAP_SYS_RESOURCE is already needed in order to overcome mqueue limits
> (msg_max and msgsize_max).


For changing the permissions on who can modify the SysV limits, I don't
think this change is safe.  I don't see anything that will prevent abuse
if anyone can modify these limits.  Replacing the ordinary unix DAC
permission check with ns_capable will allow anyone to modify the limits.


That said there is RLIMIT_MSGQUEUE that limits the posix messages queues
so those should be safe to allow anyone to modify their limits.

The code in mqueue_get_inode is where that limiting happens.

For the posix message queues all that should be needed is to change the
owner of the sysctl files from the global root to the user namespace
root.  There are also two capable calls in ipc/mqueue.c that can
probably be changed to ns_capable calls.


The only posix message queue limit that I don't immediately see
something that will prevent abuse of is /proc/sys/fs/mqueue/queus_max.
That probably still runs into RLIMIT_MSGQUEUE somewhere but it was
not immediately obvious at first glance.

Eric






>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/ipc_sysctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index ef313ecfb53a..e79452867720 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -193,16 +193,19 @@ static int set_is_seen(struct ctl_table_set *set)
>  static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
>  {
>  	int mode = table->mode;
> -
> -#ifdef CONFIG_CHECKPOINT_RESTORE
>  	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>  
> +#ifdef CONFIG_CHECKPOINT_RESTORE
>  	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
>  	    checkpoint_restore_ns_capable(ns->user_ns))
>  		mode = 0666;
> +	else
>  #endif
> +	if (ns_capable(ns->user_ns, CAP_SYS_RESOURCE))
> +		mode = 0666;
> +
>  	return mode;
>  }
