Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E8AC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiBQC5x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:57:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiBQC5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:57:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA886B12F3;
        Wed, 16 Feb 2022 18:57:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4134D1F383;
        Thu, 17 Feb 2022 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645066656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6eRmy0xNlN2fdKPLYv2w1ctFFL+lJF1HVKt4VFf25I=;
        b=y+Vz5nmTyJNuiQEeFMHKyZ7LDH8M+5jd2outxvMTt0Pq7fjTBQ7JJ/9Cq0VhNLFILStZIV
        X4D6G+5sKivNtkFgRADy3rH8tu3qAjeowmKAC7vX0fCJB2ggVYe7zus+iTYkYomZ5KLFdN
        88K8z4qHbpqb/jCoDu40UrASh3eluQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645066656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6eRmy0xNlN2fdKPLYv2w1ctFFL+lJF1HVKt4VFf25I=;
        b=77MwZlgfpUOMcqYFWIWY2ePHl3tmJhJLc/klj49UTzzu+N9w2cvbBxZAuNjMYyWLXWSKih
        zb+t6zs3/WQNDDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DE6013B3A;
        Thu, 17 Feb 2022 02:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AtNqFp65DWIuKgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 17 Feb 2022 02:57:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Stanislav Levin" <slev@altlinux.org>
Cc:     "Ian Kent" <raven@themaw.net>, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
In-reply-to: <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>,
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>,
 <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
Date:   Thu, 17 Feb 2022 13:57:26 +1100
Message-id: <164506664650.10228.15450975168088794628@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Stanislav Levin wrote:
> 
> 
> This seems duplicate of https://www.spinics.net/lists/autofs/msg02389.html
> 

Yes it is - thanks for the link.
I wonder why the proposed fix isn't in git ....

Also, I cannot see that the new NS4_ONLY_REQUESTED is different from the
existing NFS4_VERS_MASK.
They are both set/cleared at exactly the same places.

Thanks,
NeilBrown
