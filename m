Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5514C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 08:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiFGIgD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiFGIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:36:00 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2984C6E44
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:35:58 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654590957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7MJnysJhv2VicTlFbpSnJaDDTP55UbDLG13pjV5TKo=;
        b=pOUun0HAJt+xrnztwOzQLzcAN8/1Xyjh073hiDp/G9vamf3ljV26azZCPGtxiFZYYD6ZXe
        /4bOLNFAcghNbYmS4u2M101aBx5P9Hw0Cm2y0G5gInhuRehAd+We/TKdchNEfqsgE4mYfr
        307wqws5QSPixn4BpqIVG3queAENb8I=
Date:   Tue, 07 Jun 2022 08:35:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <9150a4ffa0ff94ab4697d615c60ed9b4@linux.dev>
Subject: Re: [PATCH] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
To:     "Daniel Bristot de Oliveira" <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, bsegall@google.com, vschneid@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, vincent.guittot@linaro.org
In-Reply-To: <46b7ca44-a338-e1c1-e005-326e89576211@redhat.com>
References: <46b7ca44-a338-e1c1-e005-326e89576211@redhat.com>
 <20220513024109.648471-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 7, 2022 3:55 PM, "Daniel Bristot de Oliveira" <bristot@redhat.com> w=
rote:=0A=0A> Hi Yajun=0A> =0A> On 5/13/22 04:41, Yajun Deng wrote:=0A> =
=0A>> proc_dointvec() is not applicable for unsigned integer, use=0A>> pr=
oc_douintvec_minmax() limit minimum value.=0A> =0A> I understand your pat=
ch, but your log message is somehow incomplete.=0A> =0A> Could you expand=
 on that, showing the problem using an example, and then how you=0A> see =
it fixed?=0A> =0A=0AThis patch isn't a fix. It's just an optimization for=
 match data and proc_handler in struct ctl_table.=0A=0A> Also, could you =
please add the Fixes: tag so this patch can land on stable trees?=0A> =0A=
=0AThis statement 'if (period < min || period > max)' in __checkparam_dl(=
) will work fine even if there hasn't this patch.=0ASo this patch may not=
 need land on stable trees.=0A=0A> -- Daniel
