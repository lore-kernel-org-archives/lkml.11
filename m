Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 09:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiESJVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiESJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:20:55 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F663DE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:20:50 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 0B898EEFA90;
        Thu, 19 May 2022 11:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1652952048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEpxxtS6dFfW2hXHPdJoyZva/Nsb9sB2MQUZZ8l7jNQ=;
        b=jjyGEN/2eo0tkC8gh4Uv4eViRmIwRBOkkq7tOSpJmJZnIfec0nx1ugl+MsNsuxLQ0TATA+
        e4I7m6NXv0IGWkHkh1yVRrc5S1B/WcrYeBsMWoLCDa0Ku955GNDG4yMDX9ka59LexSb7SG
        Xnzo96SgzCWHbuGF1W5o5gEqV66FNIg=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?TWljaGHFgg==?= Dec <moog621@gmail.com>,
        reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: Alternatives after removal of ReiserFS
Date:   Thu, 19 May 2022 11:20:24 +0200
Message-ID: <2631780.mvXUDI8C0e@natalenko.name>
In-Reply-To: <54db8933-f2f3-d31a-c71f-860285e25abf@gmail.com>
References: <54db8933-f2f3-d31a-c71f-860285e25abf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 18. kv=C4=9Btna 2022 14:10:25 CEST Micha=C5=82 Dec wrote:
> Does the Linux kernel actually offer any alternatives to users whose use=
=20
> cases are satisfied by ReiserFS? These users will probably be stuck with=
=20
> a much older kernel once ReiserFS is completely removed. I'm one of=20
> those users and I use ReiserFS to keep around large quantities of small=20
> files and quite ironically these are copies of the Linux kernel. I keep=20
> around 2, maybe 3 separate kernel trees to make sure the kernels I have=20
> on my devices can be rebuilt at any time.

I think the advantage of using reiserfs for small files faded away over tim=
e and became an old tale that is being passed from one generation to anothe=
r without any modern adequate testing.

XFS should serve you well.

=2D-=20
Oleksandr Natalenko (post-factum)



