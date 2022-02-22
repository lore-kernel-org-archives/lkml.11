Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3DAC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 23:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiBVXyR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiBVXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:54:14 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8452FFC3;
        Tue, 22 Feb 2022 15:53:48 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:48792)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMeyW-00D5Zz-O9; Tue, 22 Feb 2022 16:53:45 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:51066 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMeyT-008QFE-Sj; Tue, 22 Feb 2022 16:53:44 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
References: <20220221084915.554151737@linuxfoundation.org>
        <20220221084916.628257481@linuxfoundation.org>
        <20220221234610.0d23e2e0@plasteblaster>
Date:   Tue, 22 Feb 2022 17:53:12 -0600
In-Reply-To: <20220221234610.0d23e2e0@plasteblaster> (Thomas Orgis's message
        of "Mon, 21 Feb 2022 23:46:10 +0100")
Message-ID: <87sfsa8nmf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nMeyT-008QFE-Sj;;;mid=<87sfsa8nmf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18tO8ahZmJWbAsAz1uv1DwCxv6VHTabo0U=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 5.4 32/80] taskstats: Cleanup the use of task->exit_code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de> writes:

> Am Mon, 21 Feb 2022 09:49:12 +0100
> schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>: 
>
>> As best as I can figure the intent is to return task->exit_code after
>> a task exits.  The field is returned with per task fields, so the
>> exit_code of the entire process is not wanted.
>
> I wondered about the use of exit_code, too, when preparing my patch
> that introduces ac_tgid and the AGROUP flag to identify the first and
> last tasks of a task group/process, see
>
> 	https://lkml.org/lkml/2022/2/18/887
>
> With the information about the position of this task in the group,
> users can take some meaning from the exit code (individual kills?). The
> old style ensured that you got one exit code per process.

How do you figure?

For single-threaded processes ac_exitcode would always be reasonable,
and be what userspace passed to exit(3).

For multi-threaded processes ac_exitcode before my change was set to
some completely arbitrary value for the thread whose tgid == tid.

Frequently the thread whose tgid == tid is the last thread to
exit and is brought down by a call to group_exit so it makes sense.
Unfortunately there is no requirement for that to be the case.

If the thread whose tgid == tid happens to call pthread_exit the value
in ac_exitcode for that thread is pretty much undefined.

The ac_exitcode for the other threads would be the useless value of 0
that the field was initialized to.  With my change the value returned is
at least well defined.

But thread_group_leader in this context does nothing except limit the
value that is returned.

> I addressing ac_exitcode fits together with my patch, while increasing
> the version of taskstats helps clients that then can know that
> ac_exitcode now has a different meaning. Right now this is a change
> under the hood and you can just guess (or have to know from the kernel
> version).

As best as I can tell I did not change the meaning of the field.  I
change buggy code, and removed an arbitrary and senseless filter.

Now maybe it would have been better to flag the bug fix with a version
number.  Unfortunately I did not even realize taskstats had a version
number.  I just know the code made no sense.

Eric
