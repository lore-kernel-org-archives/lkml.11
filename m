Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B120DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jan 2022 17:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiAQRbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jan 2022 12:31:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47644 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiAQRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:31:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44742)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Vqt-00HRqg-CU; Mon, 17 Jan 2022 10:31:31 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47238 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Vqs-00FkwG-D8; Mon, 17 Jan 2022 10:31:31 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
        <87tuf79gni.fsf@email.froward.int.ebiederm.org>
        <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
        <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
        <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
        <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
        <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
Date:   Mon, 17 Jan 2022 11:31:22 -0600
In-Reply-To: <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com> (Mike
        Christie's message of "Mon, 17 Jan 2022 10:41:05 -0600")
Message-ID: <874k62b76d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9Vqs-00FkwG-D8;;;mid=<874k62b76d.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/12qxSuzbVIP5mosEcqpM6N5wKVRUr9o=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>> All I am certain of is that you need to set
>> "args->exit_signal = -1;".  This prevents having to play games with
>> do_notify_parent.
>
> Hi Eric,
>
> I have all your review comments handled except this one. It's looking like it's
> more difficult than just setting the exit_signal=-1, so I wanted to check that
> I understood you.

[snip problems with exit_signal = -1]

>
> What do you think?

I was wrong.  I appear to have confused the thread and the non-thread
cases.

Perhaps I meant "args->exit_signal = 0".  That looks like
do_notify_parent won't send it, and thread_group_leader continues to do
the right thing.

Baring any additional confusion on my part that cleanly solves the
problem of how not to send a signal from a child process cleanly.

My apologies for sending you on a wild goose chase.

Eric


