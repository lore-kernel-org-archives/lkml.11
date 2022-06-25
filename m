Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F7C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 23:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiFYXBN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiFYXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16614032
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E08760F6C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 23:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B16C3411C;
        Sat, 25 Jun 2022 23:01:07 +0000 (UTC)
Date:   Sat, 25 Jun 2022 19:01:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220625190105.750bbb0a@rorschach.local.home>
In-Reply-To: <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
        <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
        <20220625134552.08c1a23a@rorschach.local.home>
        <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 18:50:30 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > On Jun 25, 2022, at 1:45 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Sat, 25 Jun 2022 17:15:07 +0000
> > Chuck Lever III <chuck.lever@oracle.com> wrote:
> >   
> >> [root@manet ~]# cat /etc/redhat-release 
> >> Fedora release 35 (Thirty Five)
> >> [root@manet ~]# trace-cmd version
> >> 
> >> trace-cmd version 2.9.2 (not-a-git-repo)  
> > 
> > Ug, that's very old. Fedora should be shipping 3.1.1 soon.  
> 
> Right -- this version doesn't recognize get_sockaddr either.
> 

That would be libtraceevent that would do that. What version do you
have installed?

-- Steve
