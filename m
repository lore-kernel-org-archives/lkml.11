Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60904C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 16:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiESQpR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiESQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:45:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8A59095;
        Thu, 19 May 2022 09:45:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD65E1FA90;
        Thu, 19 May 2022 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652978712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U548y7wH3UcsDxDWZRXnGHjViQr6zgFmh8zCYvycdiI=;
        b=Cu+15Ol8cSpfF+0sMpGHKwf5JY2TgPwNb4aI2LyBnrGh05KVKNa+xwHCMwRjVuYlVtN6Bg
        Zuq1AJc8AFOTAzyfDC7Dnd5ePTDhwqfxjdCFXNno+uhJ9zQXO9Zubt7pG/OXW8sl1uxRLg
        5/Br8Y58aNwYBb6W8ZvgEUQEAygW7Kk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9025613456;
        Thu, 19 May 2022 16:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ghlBIhh0hmKqBgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 16:45:12 +0000
Date:   Thu, 19 May 2022 18:45:11 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 4/4] memcg: enable accounting for allocations in
 alloc_fair_sched_group
Message-ID: <20220519164511.GI16096@blackbody.suse.cz>
References: <Ynv7+VG+T2y9rpdk@carbon>
 <30f5b95a-db87-3924-6ad0-4c302c924ff0@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30f5b95a-db87-3924-6ad0-4c302c924ff0@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 06:52:20PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Michal Koutný <mkoutny@suse.com>
