Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 10:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356601AbiDDKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356705AbiDDKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:13:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699B26106;
        Mon,  4 Apr 2022 03:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44A4BB81227;
        Mon,  4 Apr 2022 10:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B353C34111;
        Mon,  4 Apr 2022 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649067066;
        bh=qW2/UM+ctftQ/nFJ5keMFAp3D2uZo195LddVLWRn9M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3bkyH/Ns269aOd6Dmr+PG8VAZFqlY2KIeK2edH6dSKZZ7WD/0fX/tNnCTJBjlycI
         O7SbNAnfkUca+EfEMuHsJJnJzYhChuCzjS8+j1+XY877Ruwz3zaBIwZQSKvQZZNo9c
         D5Y15lHyjhHKa5ptQUM3ZVUMRbedR1XUyQC7iUp8gPctrzf+18jsuaaTFbsCm3Ebr+
         FzPM7Ex/n264x3kJuDqAPp/Z3qHale0rQVhidZ+1Ej0nSVoLXjEOqfgbkolt1UPCID
         K4DDfk7nptgFSOKsPWZE/CiPMUugWGHy+ECBZXEtaMEuE05VCi8b83Csz8aekrF/Ra
         XN+fo7l7/fCLg==
From:   Will Deacon <will@kernel.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, agross@kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nleeder@codeaurora.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf: qcom_l2_pmu: fix an incorrect NULL check on list iterator
Date:   Mon,  4 Apr 2022 11:10:49 +0100
Message-Id: <164906580361.27128.10563595715556623445.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220327055733.4070-1-xiam0nd.tong@gmail.com>
References: <20220327055733.4070-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 13:57:33 +0800, Xiaomeng Tong wrote:
> The bug is here:
> 	return cluster;
> 
> The list iterator value 'cluster' will *always* be set and non-NULL
> by list_for_each_entry(), so it is incorrect to assume that the
> iterator value will be NULL if the list is empty or no element
> is found.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf: qcom_l2_pmu: fix an incorrect NULL check on list iterator
      https://git.kernel.org/arm64/c/2012a9e27901

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
