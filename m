Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED1AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 08:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiFOIAR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFOIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:00:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968142A29
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67622B81CD1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504EBC3411C;
        Wed, 15 Jun 2022 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655280010;
        bh=6o2MLb7XsHU6M7CsxZwl9gU0PjtAnZxBcDJopoaGghk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J73RlTgReelg60xIHa6SbH9ABCINdG6etM3gufAng5o/7xJta1xs0IfGGfcHazS8m
         aZAi0dajO7cTixfjIfrGvsbPdYhJCFYIsrjXypRuFrCa7Vmg/UzrE/Ksvc9Z8/GGQM
         V1R3xHUGZPN6FCJFKR3Z0Q87Ce2r65zodfEQymgxSZkjFIt4+Fw5Zfgrh0yZIiynSe
         DJCd9mpYcolL8oprd15ZcKNyLzByWqcvxYhfln13h1YzcgiEU1Nd0V/6i3Qt2p7Sw9
         31o6UVTbPST+LX8ahzkQsyuIo24AfhVODhfZhWP4BitR75puSJg1yV3Tkqisv3jVR6
         0PjWiiItStX1g==
Date:   Wed, 15 Jun 2022 10:00:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
Message-ID: <20220615080000.qtxeosohhyfabzmg@wittgenstein>
References: <20220613060723.197407-1-avagin@gmail.com>
 <202206141412.2B0732FF6C@keescook>
 <874k0mqs5i.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874k0mqs5i.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:53:29AM +0200, Florian Weimer wrote:
> * Kees Cook:
> 
> > On Sun, Jun 12, 2022 at 11:07:22PM -0700, Andrei Vagin wrote:
> >> Right now, a new process can't be forked in another time namespace
> >> if it shares mm with its parent. It is prohibited, because each time
> >> namespace has its own vvar page that is mapped into a process address
> >> space.
> >> 
> >> When a process calls exec, it gets a new mm and so it could be "legal"
> >> to switch time namespace in that case. This was not implemented and
> >> now if we want to do this, we need to add another clone flag to not
> >> break backward compatibility.
> >> 
> >> We don't have any user requests to switch times on exec except the
> >> vfork+exec combination, so there is no reason to add a new clone flag.
> >> As for vfork+exec, this should be safe to allow switching timens with
> >> the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
> >> if a child is forked into another time namespace. With this change,
> >> vfork creates a new process in parent's timens, and the following exec
> >> does the actual switch to the target time namespace.
> >
> > This seems like a very special case. None of the other namespaces do
> > this, do they?
> 
> I think this started with CLONE_NEWPID, which had a similar delayed
> effect with unshare: it happens only after fork, not for the current
> process image.  I think it's just a limitation of the unshare interface.
> Some of the effects simply have to be delayed due to their nature.

I tried to give more context in another mail wrt to time namespaces
specifically.

For pid namespaces one problem would be that it could end up confusing a
process about its own pid. This was a more serious problem when the pid
cache was still active in glibc; but fwiw systemd still has a pid cache
afair.

Christian
