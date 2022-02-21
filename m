Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 22:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiBUWqi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:46:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiBUWqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:46:37 -0500
Received: from mxchg03.rrz.uni-hamburg.de (mxchg03.rrz.uni-hamburg.de [134.100.38.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C861EC6E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:46:13 -0800 (PST)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw05.rrz.uni-hamburg.de )
Received: from exchange.uni-hamburg.de (UN-EX-MR08.uni-hamburg.de [134.100.84.75])
        by mxchg03.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Mon, 21 Feb 2022 23:46:11 +0100 (CET)
Received: from plasteblaster (89.244.206.97) by UN-EX-MR08.uni-hamburg.de
 (134.100.84.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 23:46:11 +0100
Date:   Mon, 21 Feb 2022 23:46:10 +0100
From:   "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 5.4 32/80] taskstats: Cleanup the use of task->exit_code
Message-ID: <20220221234610.0d23e2e0@plasteblaster>
In-Reply-To: <20220221084916.628257481@linuxfoundation.org>
References: <20220221084915.554151737@linuxfoundation.org>
        <20220221084916.628257481@linuxfoundation.org>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail (x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [89.244.206.97]
X-ClientProxiedBy: UN-EX-MR07.uni-hamburg.de (134.100.84.74) To
 UN-EX-MR08.uni-hamburg.de (134.100.84.75)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 21 Feb 2022 09:49:12 +0100
schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>: 

> As best as I can figure the intent is to return task->exit_code after
> a task exits.  The field is returned with per task fields, so the
> exit_code of the entire process is not wanted.

I wondered about the use of exit_code, too, when preparing my patch
that introduces ac_tgid and the AGROUP flag to identify the first and
last tasks of a task group/process, see

	https://lkml.org/lkml/2022/2/18/887

With the information about the position of this task in the group,
users can take some meaning from the exit code (individual kills?). The
old style ensured that you got one exit code per process.

I addressing ac_exitcode fits together with my patch, while increasing
the version of taskstats helps clients that then can know that
ac_exitcode now has a different meaning. Right now this is a change
under the hood and you can just guess (or have to know from the kernel
version).


Alrighty then,

Thomas

-- 
Dr. Thomas Orgis
HPC @ Universität Hamburg
